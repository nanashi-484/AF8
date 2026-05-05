# PATTERN.sv — AF8 參考模型套件

## 概述

`PATTERN.sv` 是一個 **SystemVerilog `package`**，提供 AF8 MAC 運算的純軟體黃金參考模型。使用 FP64（`real`）進行內部運算，可作為硬體驗證的權威比對基準。

## AF8 格式定義

AF8 使用 **Sign-Magnitude** 編碼（非 IEEE 754）：

```
 7   6   5   4   3   2   1   0
┌───┬───┬───┬───┬───┬───┬───┬───┐
│ S │  E3  E2  E1  E0 │  M2  M1  M0 │
└───┴───┴───┴───┴───┴───┴───┴───┘
```

**編碼規則**：
- 正數：`{1'b0, E[3:0], M[2:0]}`
- 負數：`{1'b1, ~{E[3:0], M[2:0]}}`
- magnitude = `{E[3:0], M[2:0]}`（7-bit），若 sign=1 則反相

**解碼規則**：
- 取出 magnitude：`sign ? ~data[6:0] : data[6:0]`
- `E = magnitude[6:3]`，`M = magnitude[2:0]`
- Normal（E ≥ 1）：value = (-1)^S × M × 4^(E-7)
- Subnormal（E = 0, M = 1）：value = (-1)^S × 1 × 4^(-7)
- Zero（M = 0, E = 0）：value = 0
- NaN（E = 15）：所有 E=15 的編碼

**關鍵數值邊界**：
- Max normal：7 × 4^7 = 114,688（`0x77`）
- Min normal：1 × 4^(-6) ≈ 2.44×10^(-4)（`0x09`）
- Min subnormal：1 × 4^(-7) ≈ 6.10×10^(-5)（`0x01`）

## 函式詳解

### `af8_is_nan(af8)` → logic

解碼後檢查 exp == 15。

### `af8_is_zero(af8)` → logic

解碼後檢查 magnitude == 0（含 ±0：`0x00` 和 `0xFF`）。

### `af8_to_real(af8)` → real

將 AF8 編碼轉換為 FP64 數值。

**演算法**：
1. 解出 sign、exp、man（Sign-Magnitude 解碼）
2. value = M × 4^(E-7)（使用迴圈乘/除 4）

### `real_to_af8(val)` → logic [7:0]

將 FP64 數值轉換為 AF8 編碼，使用 RNE 捨入。

**正規化慣例**（2026-05 確立）：

使用 **[2, 8) 正規化區間**（下界慣例），與 DUT 的 `E_cand = (acc_exp + 14) >>> 1` 公式一致。此慣例使 mantissa 保持在 [2, 7] 範圍，獲得較高精度。

**Subnormal 閾值**（2026-05 修正）：
- 原始實作使用 `M_raw` 區間判斷，對極小值錯誤輸出 M=1
- 修正為純閾值判斷：
  - `abs_val < 2^(-15)` → underflow 為零
  - `2^(-15) ≤ abs_val < 5×2^(-15)` → subnormal M=1
  - `abs_val ≥ 5×2^(-15)` → normal M=1, E=1

**Zero 編碼修正**（2026-05）：
- 修正前：`{sign, 4'd0, 3'd0}` 對負號產生 `8'h80`（解碼後為 NaN）
- 修正後：正零 `8'h00`，負零 `8'hFF`（正確的 Sign-Magnitude 編碼）

### `check_match(dut_val, exp_val)` → logic

- NaN == NaN：任何 E=15 的編碼
- Zero == Zero：±0 互為匹配（不比較 sign）
- 其餘：bitwise 完全相等

### `af8_mac_ref(a, b, acc_clear)` → logic [7:0]

完整的參考 MAC 運算模型。使用 package-level `static real mac_acc_state` 在呼叫之間持續追蹤累加器狀態。

## 與硬體的對應關係

| 參考模型 | 硬體模組 | 說明 |
|----------|----------|------|
| 內聯 magnitude 解碼 | `af8_decoder` | Sign-Magnitude 解碼 |
| `a_val × b_val` (real) | `af8_multiplier` | 3×3 尾數乘法 + Base-4 指數 |
| `acc_state + product` | Aligner + `af8_adder` | 對齊後相加 |
| `real_to_af8` | `af8_normalizer` | 正規化（含 [2,8) 慣例）+ RNE |
| `mac_acc_state` | `af8_acc_register` | 累加器狀態儲存 |
