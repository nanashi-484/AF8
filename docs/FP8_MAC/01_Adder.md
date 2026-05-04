# FP8 Adder 模組

## 概述

純組合邏輯的有號尾數加法/減法器。接收 Aligner 對齊後的兩組尾數與符號，輸出 raw sum/difference 給 Normalizer。

## 參數

| 參數 | 預設值 | 說明 |
|------|--------|------|
| `MANT_WIDTH` | 28 | 輸入尾數位寬（FP32 24-bit + 4 guard bits） |

## 介面

| 方向 | 信號 | 位寬 | 說明 |
|------|------|------|------|
| input | `sign_a` | 1 | 運算元 A 符號（乘積） |
| input | `sign_b` | 1 | 運算元 B 符號（累加器） |
| input | `mant_a` | MANT_WIDTH | 對齊後尾數 A |
| input | `mant_b` | MANT_WIDTH | 對齊後尾數 B |
| input | `exp_common` | 8 | 對齊後共同指數 |
| output | `sign_out` | 1 | 結果符號 |
| output | `mant_out` | MANT_WIDTH+1 | 結果尾數（含進位） |
| output | `exp_out` | 8 | 結果指數（pass through） |

## 運作邏輯

### 路徑 1：同號加法 (`sign_a == sign_b`)

```
mant_out = {1'b0, mant_a} + {1'b0, mant_b}
sign_out = sign_a
```

- 尾數前補 1-bit `0` 作為進位預留，輸出位寬 = MANT_WIDTH+1
- 若 `mant_out[MANT_WIDTH] == 1`，表示進位，後續 Normalizer Stage 1 會處理

### 路徑 2：異號減法 (`sign_a != sign_b`)

1. 比較大小：`a_ge_b = mant_a >= mant_b`
2. 大減小：`mant_out = larger_mant - smaller_mant`（保證結果為正）
3. 結果符號跟隨較大者：
   - `mant_a >= mant_b` → `sign_out = sign_a`
   - `mant_a < mant_b` → `sign_out = sign_b`

### 指數處理

`exp_out = exp_common` — 純 pass through，所有指數調整交由 Normalizer 處理。

## 設計理由

- **大減小設計**：保證 mant_out 恆為正數，Normalizer 只需單向 LZD，不需處理負數的 2's complement 轉換
- **輸出 +1 bit**：容納進位，Normalizer 可直接判斷是否右移
- **指數 pass through**：職責分離，Adder 只做尾數運算
