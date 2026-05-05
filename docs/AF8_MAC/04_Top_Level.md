# AF8_MAC 頂層模組

## 概述

整合 AF8 MAC 全部七個子模組，提供完整的乘積-累加運算。

## 模組架構

```
AF8_MAC
  ├── af8_decoder          (×2: in_a, in_b)
  ├── af8_multiplier       (3×3 unsigned, base-4 exponent)
  ├── af8_to_fp32_aligner  (base-4→base-2, MUX tree)
  ├── af8_adder            (27-bit → 28-bit, 大減小)
  ├── af8_normalizer       (24-bit acc, one-step subnormal)
  └── af8_acc_register     (24-bit mantissa + 10-bit exp)
```

## 介面

| 方向 | 信號 | 位寬 | 說明 |
|------|------|------|------|
| input | `clk` | 1 | 時脈 |
| input | `rst_n` | 1 | 非同步重置（active-low） |
| input | `in_a` | 8 | AF8 operand A（Sign-Magnitude） |
| input | `in_b` | 8 | AF8 operand B（Sign-Magnitude） |
| input | `acc_clear` | 1 | 清除累加器 |
| output | `out_result` | 8 | AF8 累加結果 |

## 控制邏輯

### NaN 檢測與傳播

- 檢測：`exp == 4'b1111`（解碼後的指數欄位）
- 當任何輸入為 NaN：累加器強制清零，輸出 NaN（`8'h7C`）

### acc_clear

- `acc_clear = 1`：累加器回授替換為零，本週期為單次乘法
- `acc_clear = 0`：使用累加器上週期儲存值進行累加

## 訊號位寬對照

| 模組 | 尾數位寬 | 指數位寬 |
|------|----------|----------|
| Decoder | 3 (explicit) | 4 (base-4 raw) |
| Multiplier | 6 (product) | 6 (signed, base-4) |
| Aligner | 27 (padded) | 10 (signed, base-2) |
| Adder | 28 (with carry) | 10 (signed) |
| Normalizer | 24 (acc output) | 10 (signed) |
| Acc Register | 24 (stored) | 10 (signed) |

## 與 FP8_MAC 的關鍵差異

| 特性 | FP8 | AF8 |
|------|-----|-----|
| 編碼方式 | IEEE 754 | **Sign-Magnitude** |
| 乘法器 | 4×4 (8-bit) | **3×3 (6-bit)** |
| 指數基底 | Base-2 | **Base-4** |
| 對齊器 | Full Barrel Shifter | **2-bit MUX Tree** |
| 內部尾數 | 28-bit | **24-bit** |
| Subnormal | LZD + 多級移位 | **One-step** |
| NaN 編碼 | {sign, 4'd15, 3'b100} | **8'h7C**（正 NaN） |
