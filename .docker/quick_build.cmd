echo off

cd /d "%~dp0"

docker build --platform linux/amd64 -f ./Dockerfile -t theflightsims/vlmcsd:linux-amd64 .
docker build --platform linux/arm64/v8 -f ./Dockerfile -t theflightsims/vlmcsd:linux-arm64v8 .
docker build --platform linux/ppc64le -f ./Dockerfile -t theflightsims/vlmcsd:linux-ppc64le .
docker build --platform linux/s390x -f ./Dockerfile -t theflightsims/vlmcsd:linux-s390x .
docker build --platform linux/riscv64 -f ./Dockerfile -t theflightsims/vlmcsd:linux-riscv64 .