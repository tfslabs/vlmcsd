#/bin/sh

set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

for arch in amd64 arm64/v8 ppc64le s390x riscv64; do
    tag_arch=${arch//\//}
    echo "Building for architecture: $arch with tag ${tag_arch}"
    docker build --platform "linux/$arch" -f ./Dockerfile -t "theflightsims/vlmcsd:linux-$tag_arch" .
done
