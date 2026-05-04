# FP8 Accumulator Register 模組

## 概述

唯一的時序元件。儲存 Normalizer 輸出的正規化結果，回饋給 Aligner 供下一個 MAC 週期使用。非同步重置（active-low）。

## 參數

| 參數 | 預設值 | 說明 |
|------|--------|------|
| `MANT_WIDTH` | 28 | 尾數位寬 |

## 介面

| 方向 | 信號 | 位寬 | 說明 |
|------|------|------|------|
| input | `clk` | 1 | 時脈 |
| input | `rst_n` | 1 | 非同步重置（active-low） |
| input | `acc_sign_in` | 1 | 正規化後符號（來自 Normalizer） |
| input | `acc_exp_in` | 8 | 正規化後指數（bias=7） |
| input | `acc_mant_in` | MANT_WIDTH | 正規化後尾數（含 hidden bit） |
| output | `acc_sign_out` | 1 | 儲存的符號（回饋給 Aligner） |
| output | `acc_exp_out` | 8 | 儲存的指數 |
| output | `acc_mant_out` | MANT_WIDTH | 儲存的尾數 |

## 運作邏輯

### 重置

`rst_n = 0` 時，所有輸出清除為零：
```
acc_sign_out = 0
acc_exp_out  = 0
acc_mant_out = 0
```

累加器初始值為零，確保第一個 MAC 運算的累加項為 `0`。

### 正常運作

每個 `posedge clk` 取樣 Normalizer 輸出：
```
acc_sign_out <= acc_sign_in
acc_exp_out  <= acc_exp_in
acc_mant_out <= acc_mant_in
```

## 單週期 MAC 時序

```
Cycle N:
  Input → [Decoder → Multiplier → Aligner → Adder → Normalizer] → Acc_Reg (posedge clk)
           Aligner 使用 Acc_Reg 上一個週期儲存的舊值進行對齊

Cycle N+1:
  Acc_Reg 輸出回饋給 Aligner → 新一輪 MAC 運算
```

累加器是整個 MAC 資料路徑中唯一的 pipeline boundary。
