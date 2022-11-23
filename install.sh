#!/bin/bash
sudo apt update
sudo apt install -y python3 python3-pip

export PYTHONPATH=/users/cthorens
# export PYTHONPATH=/home/ubuntu

# Virtual Env  
sudo apt install -y python3.8-venv
python -m venv venv
source venv/bin/activate

# Tumult Analytics
sudo apt install -y openjdk-8-jre-headless
pip install pandas==1.4.3
pip install tmlt.analytics

# Opacus
pip install opacus
pip install torchvision

# SNSQL
pip install smartnoise-sql


# Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

cd enforce_server
cargo test
cd ..
