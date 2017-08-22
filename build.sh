#!/bin/bash
# script to build docker image

# 1. Download prerequisites

if [ ! -d cot-pdfupload ]; then
  git clone https://github.com/gorilych/cot-pdfupload.git
fi

pushd cot-pdfupload
git pull
popd

# 2. Build

sudo docker build -t gorilych/cot-pdfupload .
sudo docker push gorilych/cot-pdfupload
