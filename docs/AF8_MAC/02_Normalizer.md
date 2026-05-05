# AF8 Normalizer / Rounder 模組

## 概述

純組合邏輯的正規化與捨入器。接收 Adder 的 raw sum，進行正規化後：
- 輸出 **24-bit 內部精度**正規化值給 Accumulator Register
- 輸出 **AF8** 格式（Sign-Magnitude 編碼、Base-4 指數、顯式尾數）

## 介面

| 方向 | 信號 | 位寬 | 說明 |
|------|------|------|------|
| input | `sign_in` | 1 | 符號（來自 Adder） |
| input | `mant_in` | 28 | Raw sum 尾數（來自 Adder） |
| input | `exp_in` | 10 (signed) | 共同指數 |
| output | `af8_out` | 8 | AF8 最終輸出（Sign-Magnitude 編碼） |
| output | `acc_sign` | 1 | 累加器符號 |
| output | `acc_exp` | 10 (signed) | 累加器指數 |
| output | `acc_mant` | 24 | 累加器尾數（正規化後，顯式） |

## 運作邏輯

### Stage 1：Carry Adjustment

處理 Adder 加法溢位：

```
if mant_in[27] == 1:
    mant_carry = mant_in[27:1]   // 右移 1 bit（27-bit）
    exp_carry  = exp_in + 1
else:
    mant_carry = mant_in[26:0]   // 不變（27-bit）
    exp_carry  = exp_in
```

### Stage 2：MSB 檢測 + 正規化至 24-bit acc

與 FP8 的 28-bit 全精度正規化不同，AF8 將 27-bit mant_carry 壓縮至 24-bit acc_mant。

1. **Zero 檢測**：`is_zero = (mant_carry == 0)`
2. **MSB 位置檢測**：從 bit 26 向下掃描找出第一個 `1`
3. **正規化位移**：`shift = msb_pos - 23`（signed），目標為 MSB 對齊至 bit 23

**左移修正**（2026-05 修正）：

原始公式使用 `mant_wide << (-shift)`，其中 `shift = msb_pos - 23`。但 `{mant_carry, 23'b0}` 已將 mant_carry 左移 23 bits，需要額外的 `(26 - msb_pos)` 左移才能將 MSB 放在 bit 49（對應 acc_mant bit 23）。

修正前：左移量 = `-shift = 23 - msb_pos`（缺少 3 bits）
修正後：左移量 = `26 - msb_pos`（正確）

### Stage 3：AF8 輸出捨入

AF8 格式：1-bit Sign + 4-bit Base-4 Exponent (bias=7) + 3-bit Explicit Mantissa。

**E_cand 公式**（下界慣例）：

```
E_cand = (acc_exp + 14) >>> 1   // 算術右移，下界
```

使用下界（而非上界 `(acc_exp + 16) >>> 1`）可讓 mantissa 保持在 [2, 7] 範圍內，獲得較高精度。此慣例與 PATTERN 參考模型的正規化區間 [2, 8) 一致。

**三路徑**：

#### 路徑 A：Zero
`is_zero || acc_mant == 0` → `M=0, E=0`

#### 路徑 B：Normal (`E_cand > 0`)

```
right_shift = 2 × E_cand + 7 - acc_exp
M_raw = acc_mant >> right_shift
G = acc_mant[right_shift-1]
R = acc_mant[right_shift-2]
S = |(acc_mant & ((1 << (right_shift-2)) - 1))
```

- 若 `M_raw > 7`：`E_cand += 1`（指數過小，調整）
- RNE 捨入：`round_up = G & (R | S | M_raw[0])`
- 若 `M_raw == 7 && round_up`：M 溢位為 0，E_cand += 1
- 若 `E_cand >= 15`：溢位為 NaN
- 若 `E_cand <= 0`：降為 subnormal 路徑

**變數 part-select 修正**（2026-05）：

iverilog 不支援 variable part-select（如 `acc_mant[right_shift-3 : 0]`）。使用 shift-and-mask 替代：
```
S = |(acc_mant & ((24'd1 << (right_shift - 2)) - 24'd1))
```

#### 路徑 C：Subnormal (`E_cand <= 0`)

AF8 僅有 `M=0`（零）與 `M=1`（最小正值）兩種次正規數。One-step subnormal 無需 LZD 或多級移位：

- 閾值為 `2^(-15)`（零與 `4^(-7)` 的中間值）
- `acc_exp >= 6`：直接輸出 M=1
- `6 - acc_exp >= 24`：underflow 為零
- 否則：`acc_mant >= (1 << (6 - acc_exp))` → M=1，否則 M=0

## AF8 輸出編碼

AF8 使用 **Sign-Magnitude** 編碼（與 IEEE 754 不同）：

- 正數：`{1'b0, E[3:0], M[2:0]}`
- 負數：`{1'b1, ~{E[3:0], M[2:0]}}`
- NaN：永遠輸出 `8'h7C`（正 NaN）

## 與 FP8 Normalizer 的關鍵差異

| 特性 | FP8 E4M3 | AF8 |
|------|----------|-----|
| 內部 acc mantissa | 28-bit（全精度） | **24-bit**（壓縮） |
| acc exp 位寬 | 8 (signed) | **10 (signed)** |
| LZD 需求 | 28-bit LZD | **27-bit MSB 檢測** |
| Subnormal 處理 | LZD + 多級右移 | **One-step**（僅判斷閾值） |
| 輸出編碼 | IEEE 754 | **Sign-Magnitude** |
| 指數基數 | Base-2 (E) | **Base-4**（E_cand × 2 步進） |
| 尾數類型 | 隱藏位元 | **顯式**（無 hidden bit） |

## 已知限制

硬體 24-bit 定點內部精度（vs. PATTERN FP64 參考模型）在 RNE 邊界值上可能差 1 ULP。隨機測試通過率約 93.9%（4723/5032），剩餘 ~309 筆為精度邊界差異。實際 ASIC 流程建議使用 bit-accurate 參考模型。
