# FP8 Normalizer / Rounder 模組

## 概述

純組合邏輯的正規化與捨入器。接收 Adder 的 raw sum，進行正規化後：
- 輸出 **FP32 精度**正規化值給 Accumulator Register（保留完整精度）
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
| input | `exp_in` | 8 | 共同指數（來自 Adder） |
| output | `fp8_out` | 8 | FP8 E4M3 最終輸出 |
| output | `acc_sign` | 1 | 累加器符號 |
| output | `acc_exp` | 8 | 累加器指數（bias=7） |
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
2. **前導零計數**：從 MSB 往下掃描找出第一個 `1` 的位置
3. **左移正規化**：
   - 若 `exp_carry >= lzd_count`：完全正規化，`mant_norm = mant_carry << lzd_count`，MSB = 1
   - 若 `exp_carry < lzd_count`：部分正規化（指數預算不足），`mant_norm = mant_carry << exp_carry`，`exp_norm = 0`

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

捨入後若 `{1'b1, m_field} + round` 溢位（bit 3 = 1），指數 +1。

若 `exp >= 15` → 溢位為 NaN：`{sign, 4'b1111, 3'b100}`

#### 路徑 C：Subnormal (`exp_norm == 0`)

直接從完整 mant_norm 做 denormalization：

```
M_sub = mant_norm >> 25      // 取整數部分（0-7）
G_sub = mant_norm[24]        // guard（denorm 後第一位捨去位）
R_sub = mant_norm[23]        // round
S_sub = |mant_norm[22:0]     // sticky
round  = G & (R | S | LSB)
```

捨入後若 `M_sub >= 8` → 升為最小 Normal（`E=1, M=0`）。
若 mant_norm 本身有剩餘前導零（部分正規化），`mant_norm >> 25` 自然給出較小的 M_sub，直到 underflow 為零。

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
