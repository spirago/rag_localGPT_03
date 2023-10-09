#!/bin/bash

echo "pod started"

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
fi

source /root/miniconda3/etc/profile.d/conda.sh  # Adjust this path based on where Miniconda is installed
conda activate privategpt

# see ISSUES -> README.md
pip uninstall -y llama-cpp-python
set LLAMA_CUBLAS=1
set CMAKE_ARGS=-DLLAMA_CUBLAS=on
set FORCE_CMAKE=1
pip install llama-cpp-python --force-reinstall --upgrade --no-cache-dir  --verbose

# python ingest.py (--device_type cpu)
# python run_localGPT.py --show_sources (--device_type cpu/mps)
sleep infinity