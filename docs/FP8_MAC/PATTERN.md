# PATTERN.sv — FP8 E4M3 參考模型套件

## 概述

`PATTERN.sv` 是一個 **SystemVerilog `package`**，提供 FP8 E4M3 MAC 運算的純軟體黃金參考模型（Golden Reference Model）。它使用 FP64（`real`）進行內部運算，確保參考模型精度遠高於硬體的內部 FP32 累加器，因此可作為 hardwa re 驗證的權威比對基準。

此 package 不包含任何時序邏輯，所有函式皆為純組合的 `automatic function`，供 `TESTBED.sv` 引入後直接呼叫。

## FP8 E4M3 格式定義

```
 7   6   5   4   3   2   1   0
┌───┬───┬───┬───┬───┬───┬───┬───┐
│ S │  E3  E2  E1  E0 │  M2  M1  M0 │
└───┴───┴───┴───┴───┴───┴───┴───┘
```

| 欄位 | 位元 | 說明 |
|------|------|------|
| S | [7] | 符號位元（0=正, 1=負） |
| E | [6:3] | 指數欄位（bias=7） |
| M | [2:0] | 尾數欄位（3-bit explicit） |

**數值解碼規則**（IEEE 754 風格）：

| 條件 | 隱藏位元 | 實際值 |
|------|----------|--------|
| E = 0, M = 0 | 0 | ±0 |
| E = 0, M ≠ 0 | 0 | (-1)^S × 0.M × 2^(-6) |
| 1 ≤ E ≤ 14 | 1 | (-1)^S × 1.M × 2^(E-7) |
| E = 15 | — | NaN（所有 E=15 的編碼皆為 NaN） |

關鍵數值邊界：
- Max normal: 1.875 × 2^7 = 240（`0x7F`）
- Min normal: 1.0 × 2^(-6) ≈ 0.015625（`0x08`）
- Max subnormal: 7/8 × 2^(-6) ≈ 0.01367（`0x07`）
- Min subnormal: 1/8 × 2^(-6) ≈ 0.00195（`0x01`）

## 常數定義

```systemverilog
localparam int FP8_BIAS   = 7;      // 指數偏置
localparam int FP8_EXP_W  = 4;      // 指數位寬
localparam int FP8_MANT_W = 3;      // 尾數位寬
localparam logic [3:0] FP8_EXP_MAX = 4'd14;   // 最大正規指數
localparam logic [3:0] FP8_EXP_NAN = 4'd15;   // NaN 指數
localparam logic [7:0] FP8_NAN = {1'b0, 4'd15, 3'b100};  // 標準 NaN 編碼
```

## 函式詳解

### `fp8_is_nan(fp8)` → logic

檢查指數欄位是否為 `4'd15`。所有 E=15 的編碼皆回傳 true。

### `fp8_is_zero(fp8)` → logic

檢查 `{E, M} == 7'd0`。注意 ±0（`0x00` 和 `0x80`）皆回傳 true。

### `fp8_to_real(fp8)` → real

將 FP8 E4M3 編碼轉換為 FP64（`real`）數值。

**演算法**：
1. 解出 sign、exp_field、mant_field
2. Subnormal / Zero（E=0）：`value = M / 8 / 64 = M / 512`
3. Normal（含 NaN）：`value = (1 + M/8) × 2^(E-7)`
4. 若 sign=1，取負值

**注意**：NaN 在此函式中被當作普通 normal number 計算其 magnitude（因為 NaN 的實際數值大小不影響後續 NaN 傳播邏輯）。

### `real_to_fp8(val)` → logic [7:0]

將 FP64 數值轉換為 FP8 E4M3 編碼，使用 **Round to Nearest Even (RNE)** 捨入。

**演算法流程**：

```
輸入 real val
  │
  ├─ abs(val) == 0.0 ──→ 回傳 {sign, 4'd0, 3'd0} (zero)
  │
  ├─ 正規化：將 abs(val) 縮放至 mant_norm ∈ [1.0, 2.0)
  │   exp_actual = floor(log2(abs_val))
  │
  ├─ exp_actual > 7 ──→ 回傳 NaN（overflow）
  ├─ exp_actual < -9 ──→ 回傳 Zero（underflow）
  │
  ├─ exp_actual ≥ -6 ──→ [Normal 路徑]
  │   E = exp_actual + 7
  │   取 fraction = mant_norm - 1.0，縮放 ×64 得 6-bit
  │   M = bits[5:3], G = bit[2], R = bit[1], S = bit[0] | rem
  │   RNE: round_up = G & (R | S | LSB)
  │   若 M=7 且 round_up → M=0, E+=1（overflow 則 NaN）
  │
  └─ exp_actual ∈ [-9, -7] ──→ [Subnormal 路徑]
      M_float = mant_norm × 2^(exp_actual+9)
      RNE 捨入至整數 M_int
      若 M_int ≥ 8 → 回傳 min normal (E=1, M=0)
      若 M_int = 0 → 回傳 zero
      否則 → 回傳 subnormal (E=0, M=M_int)
```

**RNE 捨入規則**：
- Guard (G)、Round (R)、Sticky (S) 位元擷取
- `round_up = G & (R | S | LSB)`
- 當 G=1 且 (R=1 或 S=1 或 LSB=1) 時進位
- 精確中間值（G=1, R=0, S=0）→ round to even：LSB=0 則捨去，LSB=1 則進位

### `check_match(dut_val, exp_val)` → logic

比較 DUT 輸出與預期值：
- **NaN == NaN**：任何 E=15 的編碼皆視為匹配（不比較 M 欄位）
- **Zero == Zero**：±0 互為匹配（不比較 sign bit）
- **精確比對**：其餘情況需 bitwise 完全相等

### `fp8_mac_ref(a, b, acc_clear)` → logic [7:0]

完整的參考 MAC 運算模型。使用 package-level `static real mac_acc_state` 在呼叫之間持續追蹤累加器狀態（**2026-05 修正**：iverilog 不支援 function 的 `inout` 參數，改為 package-level static variable）。

**運算邏輯**：

```
1. prod_sign = a[7] ⊕ b[7]
2. 若 acc_clear → mac_acc_state = 0.0
3. 若 a 或 b 為 NaN → mac_acc_state = 0.0（汙染），回傳 NaN
4. 若 a 或 b 為 Zero：
   - acc_clear=1 → 回傳 signed zero（{prod_sign, 0, 0}）
   - acc_clear=0 → 累加器不變，回傳 real_to_fp8(mac_acc_state)
5. 一般路徑：
   mac_acc_state += fp8_to_real(a) × fp8_to_real(b)
   若 mac_acc_state == 0.0：
   - acc_clear → 回傳 signed zero
   - 否則 → 回傳 +0 (0x00)
   否則 → 回傳 real_to_fp8(mac_acc_state)
```

**設計要點**：
- Zero operand 顯式處理：避免 `real` 型別無法區分 ±0.0 的限制
- NaN 汙染累加器：當輸入含 NaN 時，累加器被清零
- **iverilog 相容性**：`inout real acc_state` 改為 package-level `static real mac_acc_state`，並提供 `mac_clear_acc()` 輔助函式
- 內部使用 FP64 精度：`acc_state` 不會因 FP8 範圍限制而失去精度，只有最終輸出才捨入回 FP8

## 與硬體的對應關係

| 參考模型 | 硬體模組 | 說明 |
|----------|----------|------|
| `fp8_to_real` | `fp8_decoder` | 解碼 FP8 為內部表示 |
| `a_val × b_val` (real) | Multiplier (4×4) | 尾數乘法 + 指數相加 |
| `acc_state + product` | Aligner + `fp8_adder` | 對齊後相加 |
| `real_to_fp8` | `fp8_normalizer` | 正規化 + RNE 捨入 |
| `acc_state` 變數 | `fp8_acc_register` | 累加器狀態儲存 |
