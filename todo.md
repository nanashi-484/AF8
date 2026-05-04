# FP8 E4M3 (Baseline) vs. AF8 (AetherFloat) MAC 單元 — 工作項目

詳細實作指引請參考 `docs/` 目錄下的文件。

## 階段一：規格定義

### ✅ 待辦任務：
- [ ] 閱讀論文 AF8 格式定義，理解 Baseline FP8 E4M3 與 AF8 在編碼方式、指數基底 (Base-2 vs Base-4)、隱藏位元、次正規數處理上的差異
- [ ] 閱讀 `docs/FP8_E4M3_MAC_Unit.md` 與 `docs/AF8_MAC_Unit.md`，理解兩種 MAC 的模組劃分與關鍵差異
- [ ] 畫出 Baseline 與 AF8 各自的 MAC 資料路徑 Block Diagram（Decoder → Multiplier → Aligner → Adder → Normalizer/Rounder → Accumulator Register）

## 階段二：Python 軟體建模與 Golden Pattern 生成

### ✅ 待辦任務：
- [ ] 實作 Baseline FP8_E4M3 類別：Float32 ↔ FP8 轉換，正確處理 Hidden Bit、Subnormal、NaN
- [ ] 實作 AF8 類別：Float32 ↔ AF8 轉換，Explicit Mantissa、Base-4 指數 (`actual_exp = 2*(E-7)`)、One-step Subnormal
- [ ] 實作 MAC 運算函式（Multiply + Accumulate）：支援兩種格式，使用內部高精度累加器 (FP32)
- [ ] 建立測試腳本：隨機生成至少 10,000 組 MAC 測資（涵蓋 Normal、Subnormal、NaN、極端值邊界），Baseline 與 AF8 各一份
- [ ] 匯出 Golden Pattern：輸入 FP8 Hex 碼與預期累加器結果，分別匯出為 `.dat` 檔案

## 階段三：Verilog RTL 設計

### ✅ 待辦任務：

#### Baseline FP8 E4M3 RTL
- [ ] Decoder：切割 S/E/M、補 Hidden Bit、處理 Subnormal 與 NaN
- [ ] Multiplier：4×4 無號乘法器（8-bit product）、指數相加、Sign XOR
- [ ] Aligner：全功能 Barrel Shifter，對齊乘積尾數與累加器尾數
- [ ] Adder：帶符號尾數加法（Sign-Magnitude 處理）
- [ ] Normalizer / Rounder：LZD 前導零檢測、左移正規化、Round-to-Nearest-Even
- [ ] Accumulator Register：內部高精度暫存器（FP32 格式）
- [ ] 頂層 MAC 模組：整合上述子模組

#### AF8 RTL
- [ ] Decoder：無 Hidden Bit、3-bit Explicit Mantissa、Base-4 指數 (`actual_exp = 2*(E-7)`)
- [ ] Multiplier：3×3 無號乘法器（6-bit product）、指數相加（Base-4）
- [ ] Aligner：2-bit 粒度 MUX 樹位移器（無需全 Barrel Shifter）
- [ ] Adder：同 Baseline 邏輯，可共用
- [ ] Normalizer / Rounder：簡化版 — One-step Subnormal（僅 M=000 / M=001），無需 LZD
- [ ] Accumulator Register：同 Baseline，可共用
- [ ] 頂層 MAC 模組：整合上述子模組

## 階段四：功能驗證

### ✅ 待辦任務：
- [ ] 撰寫 `tb_mac_baseline.v` 與 `tb_mac_af8.v`（或統一 Testbench）
- [ ] 讀取 Baseline 與 AF8 的 Golden Pattern `.dat` 檔案
- [ ] 將輸入送入對應 MAC Unit，捕獲輸出並與 Python 預期結果比對
- [ ] Debug：不一致時使用 GTKWave 追蹤波形，修正 RTL 邏輯

## 階段五：邏輯合成與功耗面積分析

### ✅ 待辦任務：
- [ ] 向學校取得 PDK 的 standard cell library (`.lib` 檔)，完成環境配置
- [ ] 邏輯合成：撰寫 Yosys 或 Design Compiler TCL script，設定 Clock 約束條件，產出 Gate-level Netlist 與面積報告
- [ ] 時序分析：檢視 Timing Report，找出 Baseline 與 AF8 各自的 Critical Path Delay
- [ ] 功耗分析：使用 OpenSTA 或 PrimeTime，設定 20% toggle rate，生成功耗報告
- [ ] 總結比較：將 Baseline vs AF8 的 Area、Delay、Power 數據整理成比較表格，對照論文 Table III 結論進行討論
