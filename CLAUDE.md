# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 專案概述

復現論文 **"The AetherFloat Family"** 中 Table III 的 MAC 單元比較，在相同製程下進行面積、延遲與功耗的公平分析：

- **Baseline FP8 E4M3**：IEEE 754 Sign-Magnitude 編碼、Hidden Bit 的 MAC 單位（4×4 Multiplier、Full Barrel Shifter、LZD）
- **AF8 (AetherFloat 8-bit)**：Base-4 指數、Explicit Mantissa 的 MAC 單位（3×3 Multiplier、2-bit MUX Tree Aligner、One-step Subnormal），宣稱面積降低 ~33%、功耗降低 ~22%

AMAX (Block-Scaling) 是張量量化預處理單元，不屬於 MAC 資料路徑，不在本專案的 Table III 比較範圍內。

詳細實作指引請參考 `docs/運算架構概覽.md`、`docs/FP8_E4M3_MAC_Unit.md`、`docs/AF8_MAC_Unit.md`。參考論文：`docs/The AetherFloat Family.pdf`

## FP8 E4M3 格式 (Baseline)

- 1-bit Sign, 4-bit Exponent, 3-bit Mantissa, Bias=7
- IEEE 754 隱藏位元規則：Normal number 補 hidden bit `1`，Subnormal 補 `0`（尾數展開為 4-bit）
- NaN 處理：E=15 皆視為 NaN（E4M3 格式無 Infinity）
- MAC 內部使用高精度累加器（FP16 或 FP32），輸出再捨入回 FP8

## AF8 格式

- 1-bit Sign, 4-bit Exponent (Bias=7), 3-bit Explicit Mantissa（無 Hidden Bit，尾數即 3-bit）
- Base-4 指數：`actual_exp = 2 * (E - 7)`，指數步進為 2
- 3×3 無號乘法器（6-bit product），面積顯著小於 Baseline 的 4×4
- Aligner 使用 2-bit 粒度 MUX 樹，無需全功能 Barrel Shifter
- One-step Subnormal：僅 M=0b000 與 M=0b001 兩種次正規數，無需 LZD 與多級移位
- 支援原生整數比較（Integer-comparable），無需 FP 專用比較器


## 開發階段（依序進行）

1. **規格定義** — 閱讀論文 AF8 格式定義，閱讀 `docs/FP8_E4M3_MAC_Unit.md` 與 `docs/AF8_MAC_Unit.md`，畫出 Baseline 與 AF8 各自的 MAC Datapath Block Diagram（Decoder → Multiplier → Aligner → Adder → Normalizer/Rounder → Accumulator Register），比較架構差異
2. **Python 軟體建模** — 分別實作 Baseline FP8_E4M3 類別與 AF8 類別，實作 MAC 運算（Multiply + Accumulate，內部使用高精度累加器），兩種格式各生成至少 10,000 組 Golden Pattern `.dat`
3. **Verilog RTL 設計** — Baseline: Decoder、4×4 Multiplier、Full Barrel Shifter Aligner、Adder、Normalizer/Rounder (LZD)、Accumulator Register。AF8: Decoder（無 Hidden Bit、Base-4）、3×3 Multiplier、2-bit MUX Tree Aligner、Adder、Simplified Normalizer（One-step Subnormal）、Accumulator Register。兩者盡可能共用 Adder 與 Accumulator Register
4. **功能驗證** — 分別撰寫 Baseline 與 AF8 的 Testbench，讀取 Golden Pattern 進行比對，用 GTKWave debug
5. **邏輯合成與分析** — Yosys/Design Compiler 合成 + OpenSTA/PrimeTime 時序功耗分析，使用學校提供的 PDK，產出 Baseline vs. AF8 的比較表格

## 工具鏈

- **Python 3** + NumPy — 軟體建模與 Golden Pattern 生成
- **Icarus Verilog** (`iverilog`) — RTL 模擬，搭配 **GTKWave** 看波形
- **Yosys** — 邏輯合成
- **OpenSTA** — 時序與功耗分析
- **學校提供的 PDK** — 製程標準元件庫（.lib 檔）

## 關鍵設計要點

- **Multiplier Array**：Baseline 4×4 (8-bit product) vs AF8 3×3 (6-bit product)，是面積與功耗差異的主要來源
- **Aligner 複雜度**：Baseline 需要全功能 Barrel Shifter（任意位移量），AF8 因 Base-4 指數僅需 2-bit 粒度 MUX 樹，大幅減少 MUX 層深度與面積
- **Normalizer / LZD**：Baseline 的前導零檢測（LZD）與多級左移是 Critical Path 之一；AF8 的 One-step Subnormal 完全消除 LZD
- **Subnormal 處理**：Baseline 需分支判斷（Hidden bit = 0）+ LZD 正規化；AF8 僅有 M=000 與 M=001 兩種次正規數，無分支、無多級移位
- **指數基底差異**：Base-2 (Baseline) vs Base-4 (AF8)，影響指數加法器與 Aligner 的位移量計算方式
