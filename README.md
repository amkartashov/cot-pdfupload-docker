# cot-pdfupload-docker
Dockerized COT PDF upload java webapp

## Build
Run ./build.sh

## Test with docker-compose

sudo docker-compose up -d

sudo docker cp /path/to/PDFs/. 29f87d78a2e1:/root/upload/

Open http://localhost:10000
