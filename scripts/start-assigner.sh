#!/usr/bin/env bash
eval "$(conda shell.bash hook)"
conda activate agent-bench
python -m src.assigner --auto-retry
