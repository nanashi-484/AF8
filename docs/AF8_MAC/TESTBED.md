# TESTBED.sv — AF8 MAC 自我驗證測試平台

## 概述

採用**自我驗證（Self-Checking）**架構：在 testbench 內部使用 `af8_pattern_pkg` 參考模型即時計算預期結果，與 DUT 輸出逐筆比對。

## DUT 介面合約

```systemverilog
module AF8_MAC (
    input  logic        clk,          // 100MHz / 10ns
    input  logic        rst_n,        // 非同步重置（active-low）
    input  logic [7:0]  in_a,         // AF8 operand A（Sign-Magnitude）
    input  logic [7:0]  in_b,         // AF8 operand B（Sign-Magnitude）
    input  logic        acc_clear,    // 清除累加器
    output logic [7:0]  out_result    // AF8 累加結果（combinational）
);
```

## 參數設定

| 參數 | 預設值 | 說明 |
|------|--------|------|
| `CLK_PERIOD` | 10 | 時脈週期 (ns) |
| `LATENCY` | 1 | 輸出延遲（週期數） |
| `RST_CYCLES` | 10 | Reset 持續週期 |
| `RANDOM_COUNT` | 5000 | 隨機測試數量 |

## 關鍵輔助 Task

### `drive_cycle(a, b, clr)`

```
1. @(posedge clk)  — register latch 上一週期結果
2. in_a <= a       — 驅動新輸入（NBA）
3. in_b <= b
4. acc_clear <= clr
5. #1              — combinational logic 穩定
```

### `check(expected, id, desc)`

比對 DUT 輸出與預期值。失敗時輸出解碼後的 AF8 欄位（sign、exp、man）。

## 測試階段

### Phase 1：Directed Corner Cases（15 組）

| 分類 | 測試案例 | 數量 |
|------|----------|------|
| Zero | ±0 × ±0, normal × ±0 | 4 |
| Normal 基本 | ±1.0 組合, 2.0×3.0=6.0, (-2.0)×(-2.0)=4.0 | 5 |
| Near limits | max × 1.0 | 1 |
| Overflow | max × 2.0 → NaN | 1 |
| Subnormal | min_sub × 1.0 | 1 |
| Underflow | min_sub² → 0 | 1 |
| NaN 傳播 | NaN × 1.0, 1.0 × NaN | 2 |

### Phase 2：Multi-Cycle Accumulation（4 條序列）

| 序列 | 內容 | 驗證重點 |
|------|------|----------|
| A | 1.0×1.0 重複 5 次 → 5.0 | 基本累加 |
| B | 1.0×2.0 + (-1.0)×2.0 → 0.0 | 正負抵消 |
| C | min_sub×1.0 重複 3 次 | Subnormal 累加 |
| D | max×1.0 + max×0.5 → NaN | 累加至 overflow |

### Phase 3：Clear & Reset Sanity

驗證 acc_clear 和 rst_n 的正確行為。

### Phase 4：Constrained Random（5000 組）

均勻分布於全部 256 種 AF8 編碼的隨機測試。~1/8 使用 acc_clear=0（連續累加）。

## AF8 測試向量編碼

**2026-05 修正**：初始測試向量使用錯誤的編碼（`{E, M}` 位元順序顛倒）。修正後的常用測試值：

| 數值 | 正數編碼 | 負數編碼 |
|------|----------|----------|
| 0.0 | `0x00` | `0xFF` |
| min_sub | `0x01` | `0xFE` |
| 0.5 | `0x32` | — |
| 1.0 | `0x39` | `0xC6` |
| 2.0 | `0x3A` | `0xC5` |
| 3.0 | `0x3B` | `0xC4` |
| 4.0 | `0x3C` | `0xC3` |
| 6.0 | `0x3E` | — |
| max | `0x77` | `0x88` |
| NaN | `0x7C` | — |

## 模擬執行

### 本地（iverilog）

```bash
cd AF8_MAC/01_RTL
iverilog -g2012 -o simv -f filelist.f
./simv
```

### 工作站（VCS）

```bash
cd AF8_MAC/01_RTL
./01_run_vcs_rtl
```

## 預期結果

- 全部 directed tests PASS
- 隨機測試通過率 ~93.9%（剩餘為 24-bit 內部精度與 FP64 參考模型的 RNE 邊界差異）
