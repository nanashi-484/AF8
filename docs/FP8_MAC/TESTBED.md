# TESTBED.sv — FP8 E4M3 MAC 自我驗證測試平台

## 概述

`TESTBED.sv` 是 FP8 E4M3 MAC 單元的頂層測試平台。它採用**自我驗證（Self-Checking）**架構：在 testbench 內部使用 `fp8_pattern_pkg` 參考模型即時計算預期結果，與 DUT 輸出進行逐筆比對，不需依賴外部 golden pattern 檔案。

## 架構圖

```
┌─────────────────────────────────────────────────────────┐
│ TESTBED                                                 │
│                                                         │
│  ┌───────────────────┐    ┌──────────────────┐          │
│  │ fp8_pattern_pkg   │    │ FP8_MAC (DUT)    │          │
│  │ (Reference Model) │    │                  │          │
│  │                   │    │ clk, rst_n       │          │
│  │ fp8_mac_ref() ───┼───→│ in_a, in_b       │          │
│  │ check_match()  ←──┼────│ acc_clear        │          │
│  │                   │    │ out_result       │          │
│  └───────────────────┘    └──────────────────┘          │
│         │                          │                    │
│         ▼                          ▼                    │
│  ┌──────────────────────────────────────┐               │
│  │          Scoreboard                   │               │
│  │  pass_cnt / fail_cnt / test_cnt      │               │
│  └──────────────────────────────────────┘               │
│                         │                                │
│                         ▼                                │
│               Test Summary Report                        │
└─────────────────────────────────────────────────────────┘
```

## DUT 介面合約

Testbench 預期 `FP8_MAC` 頂層模組符合以下介面：

```systemverilog
module FP8_MAC (
    input  logic        clk,          // 時脈（100MHz / 10ns 週期）
    input  logic        rst_n,        // 非同步重置（active-low）
    input  logic [7:0]  in_a,         // FP8 E4M3 operand A
    input  logic [7:0]  in_b,         // FP8 E4M3 operand B
    input  logic        acc_clear,    // 清除累加器（開始新的 dot product）
    output logic [7:0]  out_result    // FP8 E4M3 累加結果（combinational output）
);
```

**時序行為**（單週期 MAC）：

```
Cycle N:    in_a, in_b, acc_clear  ──comb──→  out_result (同週期)
            └─ posedge clk ──→  acc_register latches result
Cycle N+1:  acc_register 回饋至 Aligner，供下一個 MAC 使用
```

**控制信號**：
- `acc_clear=1`：本週期 MAC 運算使用 acc=0（開始新的 dot product）
- `acc_clear=0`：本週期 MAC 運算使用上一個週期的累加值
- `rst_n=0`：非同步清除累加器為零

## 參數設定

| 參數 | 預設值 | 說明 |
|------|--------|------|
| `CLK_PERIOD` | 10 | 時脈週期 (ns)，對應 100MHz |
| `LATENCY` | 1 | 輸出延遲（週期數）。1 = combinational output，2 = registered output |
| `RST_CYCLES` | 10 | Reset 持續週期數 |
| `RANDOM_COUNT` | 5000 | 隨機測試向量數量 |

## 關鍵輔助 Task

### `drive_cycle(a, b, clr)`

驅動 DUT 輸入並等待一個時脈週期：
1. 使用 non-blocking assignment (`<=`) 設定 `in_a`, `in_b`, `acc_clear`
2. 等待 `posedge clk`
3. 延遲 `#1` 讓 combinational logic 穩定（避免 Verilog race condition）

### `check(expected, id, desc)`

比對 DUT 輸出與預期值：
1. 呼叫 `check_match(out_result, expected)` 進行比對
2. 更新 `pass_cnt` / `fail_cnt`
3. 失敗時輸出詳細資訊（DUT 值、預期值、各欄位解碼）

## 測試階段

### Phase 1：Directed Corner Cases（19 組）

以手動指定的 corner case 驗證基本功能正確性。

| 分類 | 測試案例 | 數量 |
|------|----------|------|
| Zero | ±0 × ±0, normal × ±0 | 4 |
| Normal 基本 | ±1.0 組合, 2.0×3.0=6.0, (-2.0)×(-2.0)=4.0 | 5 |
| Near limits | max×1.0, max×0.5 | 2 |
| Overflow | max×2.0, 128×128 → NaN | 2 |
| Subnormal | min_sub×1.0, max_sub×1.0 | 2 |
| Underflow | min_sub², min_normal² → 0 | 2 |
| NaN 傳播 | NaN×1.0, 1.0×NaN | 2 |

每個測試皆以 `acc_clear=1` 執行（單次乘法，不累加）。

### Phase 2：Multi-Cycle Accumulation Sequences（4 條序列）

驗證連續累加的正確性。

| 序列 | 內容 | 驗證重點 |
|------|------|----------|
| A | 1.0×1.0 重複 5 次 → 5.0 | 基本累加線性 |
| B | 1.0×2.0 + (-1.0)×2.0 → 0.0 | 正負號抵消（cancellation） |
| C | min_sub×1.0 重複 3 次 | Subnormal 漸進累加 |
| D | max×1.0 + max×0.5 → NaN | 累加至 overflow |

### Phase 3：Accumulator Clear & Reset Sanity（6 組）

驗證控制信號的正確行為。

| 測試 | 說明 |
|------|------|
| acc_clear 序列 | 驗證累加中插入 acc_clear 能正確重置累加器 |
| rst_n 重置 | 驗證非同步 reset 後累加器歸零且能正常運作 |

### Phase 4：Constrained Random Tests（5000 組）

均勻分布於全部 256 種 FP8 編碼的隨機測試。

- 使用 `$random` 產生亂數種子（`32'hDEADBEEF`），確保可重現性
- ~1/8 的測試使用 `acc_clear=0`（模擬連續累加情境）
- 每 500 組輸出進度訊息

## 比對規則

`check_match()` 函式的比對邏輯：

| DUT 輸出 | 預期值 | 結果 |
|----------|--------|------|
| NaN (E=15) | NaN (E=15) | **PASS**（不比較 M 欄位） |
| Zero (E=0, M=0) | Zero (E=0, M=0) | **PASS**（不比較 sign bit） |
| 任意 | 完全相等 | **PASS** |
| 任意 | 不相等 | **FAIL** + 詳細錯誤資訊 |

## 模擬執行

### 本地（iverilog）

```bash
cd FP8_MAC/00_TESTBED
iverilog -g2012 -o simv -I ../01_RTL ../01_RTL/FP8_MAC.sv PATTERN.sv TESTBED.sv
vvp simv
```

### 工作站（VCS）

```bash
cd FP8_MAC/01_RTL
./01_run_vcs_rtl
```

## 預期輸出範例

```
============================================================
 FP8 E4M3 MAC Unit Testbench
 Latency: 1 cycle(s)
============================================================

--- Phase 1: Directed Corner Cases ---
[PASS] #500: Random #399
...
[PASS] #1000: Random #899
...

--- Phase 4: Random Tests (5000 vectors) ---
[PASS] #1500: Random #1399
...

============================================================
 TEST SUMMARY
============================================================
 Total:   5069
 Passed:  5069
 Failed:  0
============================================================
 RESULT: ALL TESTS PASSED
```

## 擴展指南

當新的硬體模組完成後，testbench 的修改方式：

1. **Decoder / Multiplier / Aligner 完成**：不需修改 testbench，這些模組被封裝在 `FP8_MAC` 內部
2. **`FP8_MAC` 頂層完成**：確認 port 名稱與 testbench 中的實例化一致即可
3. **調整管線深度**：若 MAC 改為多級管線，修改 `LATENCY` 參數
4. **增加測試**：在 Phase 1 中插入新的 `fp8_mac_ref()` + `drive_cycle()` + `check()` 呼叫
5. **增加隨機測試數量**：修改 `RANDOM_COUNT` 參數
