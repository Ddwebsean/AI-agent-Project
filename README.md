# AI-agent-Project

# AI-Trader A-Share Position Limit Modification
This is a simplified modified version of the [AI-Trader](https://github.com/HKUDS/AI-Trader) project, focusing on **risk control optimization for A-share trading agents** (SSE-50 Index). The core modification adds a 20% position concentration limit per stock, aligning with the original paper's key finding: "Risk control capability determines cross-market robustness".

---

## Table of Contents
1. [Key Modifications](#key-modifications)
2. [Prerequisites](#prerequisites)
3. [Quick Installation](#quick-installation)
4. [How to Run](#how-to-run)
5. [Output Results](#output-results)
6. [Troubleshooting](#troubleshooting)

---

## Key Modifications
Only 3 files are added/modified (isolated changes, no impact on original functions):
1. `agent/base_agent_astock/base_agent_astock.py`: Added `check_position_limit()` method to restrict single-stock position ≤20% of total assets.
2. `configs/astock_position_limit_config.json`: Configuration file for the modified agent (100k initial cash, SSE-50 data).
3. `scripts/run_astock_modification.sh`: One-click script to run the experiment.

Retains A-share rules (T+1, 100-share lots) and original MCP toolchain (Check Price/Search/Trade).

---

## Prerequisites
### 1. Software
- Python 3.10.x
- Git
- OS: Windows 11 (WSL2), macOS 12+, or Linux

### 2. Required API Keys
Apply for free keys:
- [DeepSeek API Key](https://www.deepseek.com/) (for LLM reasoning)
- [Tushare Token](https://tushare.pro/) (for A-share data)
- [Alpha Vantage API Key](https://www.alphavantage.co/) (backup data source)

---

## Quick Installation
### 1. Clone & Enter Project
```bash
git clone https://github.com/HKUDS/AI-Trader.git
cd AI-Trader
```

### 2. Create Virtual Env
```bash
# Create env
python3 -m venv .venv

# Activate env
# Windows (WSL2/macOS/Linux)
source .venv/bin/activate
# Windows (Git Bash)
.venv/Scripts/activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Configure API Keys
```bash
# Copy example file
cp .env.example .env

# Edit .env (add your keys)
nano .env  # Or use Notepad/VS Code
```

Paste these lines (replace placeholders):
```ini
OPENAI_API_BASE=https://api.deepseek.com/v1
OPENAI_API_KEY=your_deepseek_key
TUSHARE_TOKEN=your_tushare_token
ALPHAADVANTAGE_API_KEY=your_alpha_vantage_key
```

---

## How to Run
### Mode 1: One-Click Run (Recommended)
```bash
# Make script executable
chmod +x scripts/run_astock_modification.sh

# Start experiment
bash scripts/run_astock_modification.sh
```
This script automatically:
1. Prepares A-share data
2. Starts MCP services
3. Runs the modified agent (20% position limit)
4. Generates performance charts
5. Stops services

### Mode 2: Step-by-Step (For Debug)
```bash
# Step 1: Prepare data
bash scripts/main_a_stock_step1.sh

# Step 2: Start MCP services (new terminal)
bash scripts/main_a_stock_step2.sh

# Step 3: Run modified agent (new terminal)
python main.py configs/astock_position_limit_config.json

# Step 4: Generate charts
python tools/plot_metrics.py --data-dir ./data/agent_data_astock_position_limit --output-dir ./results
```

---

## Output Results
All results are saved in the project folder:
1. **Trading Logs**: `data/agent_data_astock_position_limit/`
   - `position.jsonl`: Daily holdings, cash, total assets.
   - `log/`: LLM reasoning and tool calls.

2. **Performance Charts**: `results/`
   - 4 key charts: Cumulative Return, Sortino Ratio, Volatility, Maximum Drawdown.
   - `metrics.csv`: Raw data for reports.

3. **Key Metrics (Example)**:
| Scenario               | Cumulative Return | Sortino Ratio | Volatility | Max Drawdown |
|------------------------|-------------------|---------------|------------|--------------|
| Original Agent         | -1.17%            | -0.15         | 9.87       | -5.72%       |
| Modified Agent (20% Limit) | -0.83%      | 0.03          | 7.62       | -3.21%       |

---

## Troubleshooting
| Issue                          | Solution                                                                 |
|--------------------------------|--------------------------------------------------------------------------|
| "pip: command not found"       | Use `python3 -m pip` instead of `pip` (ensure env is activated).         |
| Data fetch failed (Tushare)    | Upgrade Tushare to Level 1 (complete real-name auth) or use Alpha Vantage. |
| Port conflict (8000)           | Modify port numbers in `.env` (e.g., 8000→8004) and restart services.    |
| LLM API timeout                | Check network or reduce `AGENT_MAX_STEP` in `.env` (30→20).              |

---

## Homework Notes
- **GitHub**: Submit the repo URL (commit msg: `Add 20% position limit for A-share agent`).
- **Report**: Use charts in `results/` and metrics from `metrics.csv`.
- **Reproducibility**: Instructor can run the one-click script to verify results.
