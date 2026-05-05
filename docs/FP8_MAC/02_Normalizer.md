# FP8 Normalizer / Rounder 模組

## 概述

純組合邏輯的正規化與捨入器。接收 Adder 的 raw sum，進行正規化後：
- 輸出 **內部精度**正規化值給 Accumulator Register（保留完整精度，exp 可為負值）
- 輸出 **FP8 E4M3** 格式給外部（RNE 捨入）

## 參數

| 參數 | 預設值 | 說明 |
|------|--------|------|
| `MANT_WIDTH` | 28 | 尾數位寬 |

內部常數：`DENORM_SHIFT = MANT_WIDTH - 3 = 25`

## 介面

| 方向 | 信號 | 位寬 | 說明 |
|------|------|------|------|
| input | `sign_in` | 1 | 符號（來自 Adder） |
| input | `mant_in` | MANT_WIDTH+1 | Raw sum 尾數（來自 Adder） |
| input | `exp_in` | 8 (signed) | 共同指數（bias=7，可為負值） |
| output | `fp8_out` | 8 | FP8 E4M3 最終輸出 |
| output | `acc_sign` | 1 | 累加器符號 |
| output | `acc_exp` | 8 (signed) | 累加器指數（bias=7，可為負值） |
| output | `acc_mant` | MANT_WIDTH | 累加器尾數（正規化後，含 hidden bit） |

## 運作邏輯

### Stage 1：Carry Adjustment

處理 Adder 加法溢位：

```
if mant_in[MANT_WIDTH] == 1:
    mant_carry = mant_in[MANT_WIDTH:1]   // 右移 1 bit
    exp_carry  = exp_in + 1
else:
    mant_carry = mant_in[MANT_WIDTH-1:0] // 不變
    exp_carry  = exp_in
```

### Stage 2：LZD + Normalization

1. **Zero 檢測**：`is_zero = (mant_carry == 0)` → 直接輸出零
2. **前導零計數**：使用 iverilog 相容寫法（無 `break`），從 MSB 往下掃描找出第一個 `1` 的位置
3. **三路徑正規化**（exp 為 signed，可為負值）：
   - 若 `exp_carry >= lzd_count`：完全正規化，`mant_norm = mant_carry << lzd_count`，MSB = 1
   - 若 `exp_carry > 0` 但 `< lzd_count`：部分正規化，`mant_norm = mant_carry << exp_carry`，`exp_norm = 0`
   - 若 `exp_carry <= 0`：無法左移，保留 mant_carry 原值與負的 exp_carry，由 Stage 3 subnormal 路徑處理

### Stage 3：RNE 捨入 + FP8 封裝

三條平行路徑，依 `is_zero` / `exp_norm` 選擇：

#### 路徑 A：Zero

`mant_carry == 0` → `fp8_out = {sign_in, 7'd0}`

#### 路徑 B：Normal (`exp_norm >= 1`)

尾數已完全正規化（MSB = 1），將小數部分捨入為 3-bit：

```
m_field = mant_norm[26:24]   // 前 3 bit 小數
G       = mant_norm[23]      // guard
R       = mant_norm[22]      // round
S       = |mant_norm[21:0]   // sticky
round   = G & (R | S | m_field[0])
```

**捨入溢位偵測**（2026-05 修正）：
- 原程式使用 `mant_rnd[3]` 判斷溢位，但 `{1'b1, m_field}` 的 bit[3] = hidden bit（永遠為 1），導致每次正常數都錯誤地對指數 +1
- 修正為：`overflow = (m_field == 3'b111) && round` — 僅在 M=7 且需進位時才溢位

捨入後若溢位（M=7 + round → M=8），指數 +1。

若 `exp >= 15` → 溢位為 NaN：`{sign, 4'b1111, 3'b100}`

#### 路徑 C：Subnormal (`exp_norm <= 0`)

exp_norm 可能為 0 或負值（乘積極小時）。動態計算 denorm 位移量：

```
sub_shift = DENORM_SHIFT - exp_norm   // exp_norm 為負時增加位移量
M_sub = mant_norm >> sub_shift        // 取整數部分（0-7）
G_sub = mant_norm[sub_shift-1]        // guard
R_sub = mant_norm[sub_shift-2]        // round（若 sub_shift >= 2）
S_sub = |mant_norm[0 : sub_shift-3]   // sticky（若 sub_shift >= 3）
round  = G & (R | S | LSB)
```

- 若 `sub_shift >= MANT_WIDTH` → underflow 為零
- 若 `M_sub + round >= 8` → 升為最小 Normal（`E=1, M=0`）
- 否則輸出 subnormal（`E=0, M=M_sub[2:0]`）

## RNE 捨入規則

**Round to Nearest Even**：只有在 guard bit = 1 **且** (round bit、sticky bit、LSB 任一為 1) 時才進位。

```
round_up = G & (R | S | LSB)
```

這保證了 tie（`G=1, R=0, S=0`）時只有 LSB=1 才進位 → 捨入到偶數。

## FP8 E4M3 輸出格式

| 位元 | 說明 |
|------|------|
| `[7]` | Sign |
| `[6:3]` | Exponent (bias=7, E=15 保留給 NaN) |
| `[2:0]` | Mantissa (3-bit explicit, hidden bit 由 E 決定) |

## 已知限制：RNE 邊界精度

硬體使用 28-bit 定點 mantissa（bias=7, signed exp），PATTERN 參考模型使用 FP64（~53-bit mantissa）。在 RNE 捨入的邊界值（tie case）上，兩者可能差 1 ULP。隨機測試通過率約 95%（4791/5036），剩餘 ~245 筆皆為 RNE 1-ULP 邊界差異。

測試 bias=127 並未改善此精度（通過率 +0.1%），因為 LZD 永遠將 mantissa 正規化到 MSB=1，G/R/S 位元位置不受 bias 影響。實際 ASIC 驗證應使用 bit-accurate 參考模型。
