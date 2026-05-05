# AF8 Accumulator Register 模組

## 概述

唯一的時序元件。儲存 Normalizer 輸出的正規化結果，回饋給 Aligner 供下一個 MAC 週期使用。非同步重置（active-low）。

## 介面

| 方向 | 信號 | 位寬 | 說明 |
|------|------|------|------|
| input | `clk` | 1 | 時脈 |
| input | `rst_n` | 1 | 非同步重置（active-low） |
| input | `acc_sign_in` | 1 | 正規化後符號（來自 Normalizer） |
| input | `acc_exp_in` | 10 (signed) | 正規化後指數 |
| input | `acc_mant_in` | 24 | 正規化後尾數（顯式，MSB 在 bit 23） |
| output | `acc_sign_out` | 1 | 儲存的符號（回饋給 Aligner） |
| output | `acc_exp_out` | 10 (signed) | 儲存的指數 |
| output | `acc_mant_out` | 24 | 儲存的尾數 |

## 與 FP8 Acc Register 的差異

| 特性 | FP8 | AF8 |
|------|-----|-----|
| 尾數位寬 | 28 | **24** |
| 指數位寬 | 8 (signed) | **10 (signed)** |
| 初始值 | 0 | 0 |
| 重置方式 | async active-low | 相同 |

## 單週期 MAC 時序

```
Cycle N:
  Input → [Decoder → Multiplier → Aligner → Adder → Normalizer] → Acc_Reg (posedge clk)
           Aligner 使用 Acc_Reg 上一個週期儲存的舊值進行對齊

Cycle N+1:
  Acc_Reg 輸出回饋給 Aligner → 新一輪 MAC 運算
```

累加器是整個 MAC 資料路徑中唯一的 pipeline boundary。
