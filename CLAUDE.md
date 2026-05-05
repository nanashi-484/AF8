# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 專案概述

復現論文 **"The AetherFloat Family"** 中 Table III 的 MAC 單元比較，在相同製程下進行面積、延遲與功耗的公平分析：

- **Baseline FP8 E4M3**：IEEE 754 Sign-Magnitude 編碼、Hidden Bit 的 MAC 單位（4×4 Multiplier、Full Barrel Shifter、LZD）
- **AF8 (AetherFloat 8-bit)**：Base-4 指數、Explicit Mantissa 的 MAC 單位（3×3 Multiplier、2-bit MUX Tree Aligner、One-step Subnormal），宣稱面積降低 ~33%、功耗降低 ~22%

AMAX (Block-Scaling) 是張量量化預處理單元，不屬於 MAC 資料路徑，不在本專案的 Table III 比較範圍內。

詳細實作指引請參考 `docs/運算架構概覽.md`、`docs/FP8_E4M3_MAC_Unit.md`、`docs/AF8_MAC_Unit.md`。參考論文：`docs/The AetherFloat Family.pdf`

## 協作分工

此專案為兩人協作，MAC 資料路徑模組分工如下：

- **lunn-rocks**：Decoder、Multiplier、Aligner（含之前的模組）
- **nanashi-484**：Adder、Normalizer / Rounder、Accumulator Register、頂層 MAC 整合

兩人的 SystemVerilog 檔案分別存放於各格式的目錄中，最後合併：

```
FP8_MAC/    ← Baseline FP8 E4M3 的 RTL 模組（.sv），含 01_RTL / 00_TESTBED / 02_SYN / 03_GATE
AF8_MAC/    ← AF8 的 RTL 模組（.sv），含 01_RTL / 00_TESTBED / 02_SYN / 03_GATE
```

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
2. ~~**Python 軟體建模**~~（已跳過）— 直接使用 RTL 模擬進行功能驗證，不產生 Golden Pattern
3. **Verilog RTL 設計** — Baseline: Decoder、4×4 Multiplier、Full Barrel Shifter Aligner、Adder、Normalizer/Rounder (LZD)、Accumulator Register。AF8: Decoder（無 Hidden Bit、Base-4）、3×3 Multiplier、2-bit MUX Tree Aligner、Adder、Simplified Normalizer（One-step Subnormal）、Accumulator Register。兩者盡可能共用 Adder 與 Accumulator Register
4. **功能驗證** — 使用內建參考模型（`PATTERN.sv`）的自我驗證 Testbench（`TESTBED.sv`），直接在測試中產生預期結果進行比對。不依賴外部 Golden Pattern 檔案。
5. **邏輯合成與分析** — Design Compiler 合成 + PrimeTime 時序功耗分析，使用學校提供的 PDK，產出 Baseline vs. AF8 的比較表格

### 目前進度

| 模組 | 負責人 | 狀態 | 檔案 |
|------|--------|------|------|
| Decoder | lunn-rocks | ✅ 完成（已修正 subnormal 指數） | `FP8_MAC/01_RTL/FP8_MAC.sv` |
| Multiplier (4×4) | lunn-rocks | ✅ 完成（已修正指數公式） | `FP8_MAC/01_RTL/FP8_MAC.sv` |
| Aligner (Barrel Shifter) | lunn-rocks | ✅ 完成（已修正 exp 位寬） | `FP8_MAC/01_RTL/FP8_MAC.sv` |
| Adder | **nanashi-484** | ✅ 完成（已改為 signed exp） | `FP8_MAC/01_RTL/FP8_MAC.sv` |
| Normalizer / Rounder | **nanashi-484** | ✅ 完成（已修正溢位偵測、LZD、signed exp） | `FP8_MAC/01_RTL/FP8_MAC.sv` |
| Accumulator Register | **nanashi-484** | ✅ 完成（已改為 signed exp） | `FP8_MAC/01_RTL/FP8_MAC.sv` |
| 頂層 MAC 整合 | **nanashi-484** | ✅ 完成（含 NaN 傳播、acc_clear） | `FP8_MAC/01_RTL/FP8_MAC.sv` |
| Testbench (TESTBED) | **nanashi-484** | ✅ 完成（已修正時序） | `FP8_MAC/00_TESTBED/TESTBED.sv` |
| Reference Model (PATTERN) | **nanashi-484** | ✅ 完成（已修正 iverilog 相容性） | `FP8_MAC/00_TESTBED/PATTERN.sv` |

詳細模組規格文件：
- `docs/FP8_MAC/01_Adder.md`
- `docs/FP8_MAC/02_Normalizer.md`
- `docs/FP8_MAC/03_Accumulator_Register.md`
- `docs/FP8_MAC/PATTERN.md` — FP8 E4M3 參考模型（package 內各函式的演算法與格式對應）
- `docs/FP8_MAC/TESTBED.md` — Testbench 架構、DUT 介面合約、測試流程說明

## 工具鏈

- **Synopsys VCS** — RTL 與 Gate-level 模擬（工作站）
- **Synopsys Design Compiler** — 邏輯合成（工作站）
- **Synopsys PrimeTime** — 時序與功耗分析（工作站）
- **Icarus Verilog** (`iverilog`) — 本地輕量 RTL 模擬，搭配 **GTKWave** 看波形
- **Yosys** — 本地輕量邏輯合成（工作站前自測）
- **學校提供的 PDK** — 製程標準元件庫（.lib 檔）

## 工作站測試與合成流程

於工作站環境依序執行以下腳本，分別完成 RTL 模擬、電路合成與 Gate-level 模擬：

```bash
# 1. RTL 模擬（VCS）
cd $專案/01_RTL && ./01_run_vcs_rtl

# 2. 電路合成（Design Compiler）
cd $專案/02_SYN && ./01_run_dc

# 3. Gate-level 模擬（VCS + SDF）
cd $專案/03_GATE && ./01_run_vcs_gate
```

每個步驟的輸出結果（模擬 log、合成報告、時序/功耗報告）請保留於對應目錄中。

### 合成時序約束（syn.tcl）

FP8_MAC 為純組合邏輯 MAC（僅內部 acc_register 為 sequential），input/output 來自外部 register：

| 約束 | 值 | 說明 |
|------|-----|------|
| `CYCLE` | 10.0 ns | 100 MHz |
| `INPUT_DLY` | 1.0 ns (10%) | 外部 clock-to-Q + wire（不可用 50%，會佔滿週期） |
| `OUTPUT_DLY` | 1.0 ns (10%) | wire + 外部 setup |
| `clock_uncertainty` | 0.1 ns | 抖動裕量 |

若合成出現 slack violation，優先檢查 input/output delay 是否過於保守。實際組合邏輯延遲約 5.26ns，理論最高頻率約 190 MHz。

## 關鍵設計要點

- **Multiplier Array**：Baseline 4×4 (8-bit product) vs AF8 3×3 (6-bit product)，是面積與功耗差異的主要來源
- **Aligner 複雜度**：Baseline 需要全功能 Barrel Shifter（任意位移量），AF8 因 Base-4 指數僅需 2-bit 粒度 MUX 樹，大幅減少 MUX 層深度與面積
- **Normalizer / LZD**：Baseline 的前導零檢測（LZD）與多級左移是 Critical Path 之一；AF8 的 One-step Subnormal 完全消除 LZD
- **Subnormal 處理**：Baseline 需分支判斷（Hidden bit = 0）+ LZD 正規化；AF8 僅有 M=000 與 M=001 兩種次正規數，無分支、無多級移位
- **指數基底差異**：Base-2 (Baseline) vs Base-4 (AF8)，影響指數加法器與 Aligner 的位移量計算方式

## 已確定的設計決策

- **管線深度**：單週期 MAC（純組合邏輯 + Accumulator Register），與論文 Table III 比較方式一致
- **內部精度**：FP32 尾數精度（24-bit mantissa + 4 guard bits），`MANT_WIDTH = 28`
- **指數 Bias**：內部統一使用 bias=7（與 FP8 E4M3 相同），8-bit 指數欄位（`signed`）
- **捨入模式**：Round to Nearest Even (RNE)，`round = G & (R | S | LSB)`
- **NaN 編碼**：`{sign, 4'b1111, 3'b100}`（E=15 皆視為 NaN，E4M3 無 Infinity）
- **Adder 設計**：大減小架構，保證輸出 mantissa 恆為正，Normalizer 只需單向 LZD
- **Accumulator Register**：非同步 reset (active-low)，初始值為零，每週期 latch

### bias=127 測試結論（2026-05-05）

測試將內部 bias 從 7 改為 127（對齊 FP32），結論：
- bias=7: 4791/5036 (95.1%)
- bias=127: 4796/5036 (95.2%)，僅 +0.1%
- **bias 不影響 RNE 精度**：因為 LZD 永遠將 mantissa 正規化到 MSB=1，G/R/S 位元提取位置不受 bias 影響；subnormal 路徑的 `sub_shift` 在兩種 bias 下產生相同位移量
- 剩餘 ~240 筆失敗是硬體 28-bit 定點精度與 PATTERN FP64 參考模型的固有落差，在實際 ASIC 流程中使用 bit-accurate 模型即可消除
