#!/bin/bash
# 作业修改版：运行带持仓限制的A股代理实验
echo "=== Starting A-Share Agent with Position Limit Modification ==="

# 步骤1：检查Python环境
if ! command -v python3 &> /dev/null; then
    echo "Error: Python3 is not installed"
    exit 1
fi

# 步骤2：进入项目根目录
cd "$(dirname "$0")/.." || exit 1
echo "Current directory: $(pwd)"

# 步骤3：安装依赖（如需）
echo "Installing dependencies..."
pip3 install -r requirements.txt

# 步骤4：准备A股数据
echo "Preparing A-Share data..."
bash scripts/main_a_stock_step1.sh

# 步骤5：启动MCP服务（后台运行）
echo "Starting MCP services..."
bash scripts/main_a_stock_step2.sh &
MCP_PID=$!
sleep 10  # 等待服务启动

# 步骤6：运行修改后的A股代理
echo "Running A-Share Agent with position limit (20%)..."
python3 main.py configs/astock_position_limit_config.json

# 步骤7：停止MCP服务
echo "Stopping MCP services..."
kill $MCP_PID

# 步骤8：生成性能分析图表
echo "Generating performance metrics..."
python3 tools/plot_metrics.py --data-dir ./data/agent_data_astock_position_limit --output-dir ./results/astock_modification

echo "=== Experiment Completed ==="
echo "Results saved to: ./data/agent_data_astock_position_limit"
echo "Metrics plots saved to: ./results/astock_modification"