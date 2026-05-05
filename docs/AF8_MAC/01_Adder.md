# AF8 Adder 模組

## 概述

純組合邏輯的有號尾數加法/減法器。接收 Aligner 對齊後的兩組尾數與符號，輸出 raw sum/difference 給 Normalizer。

與 FP8 Adder 架構相同（大減小設計），但位寬不同（27-bit → 28-bit，10-bit signed exp）。

## 介面

| 方向 | 信號 | 位寬 | 說明 |
|------|------|------|------|
| input | `sign_a` | 1 | 運算元 A 符號（乘積） |
| input | `sign_b` | 1 | 運算元 B 符號（累加器） |
| input | `mant_a` | 27 | 對齊後尾數 A |
| input | `mant_b` | 27 | 對齊後尾數 B |
| input | `exp_common` | 10 (signed) | 對齊後共同指數 |
| output | `sign_out` | 1 | 結果符號 |
| output | `mant_out` | 28 | 結果尾數（含進位） |
| output | `exp_out` | 10 (signed) | 結果指數（pass through） |

## 與 FP8 Adder 的差異

| 特性 | FP8 | AF8 |
|------|-----|-----|
| 輸入尾數位寬 | 28 | **27** |
| 輸出尾數位寬 | 29 | **28** |
| 指數位寬 | 8 (signed) | **10 (signed)** |
| 運算邏輯 | 大減小 | 相同 |

## 設計理由

- **大減小設計**：保證 mant_out 恆為正數，AF8 Normalizer 只需單向 LZD
- **指數 pass through**：職責分離，Adder 只做尾數運算
