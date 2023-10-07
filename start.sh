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
conda activate ludwig
# python /ludwig_finetune.py
sleep infinity