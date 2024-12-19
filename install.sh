#!/system/bin/env sh
#
# Setup pacman in termux
set -e

cd "${PREFIX%/*}"
mkdir -p ./tqs
cd ./tqs
curl -ZLo tqs.zip 'https://github.com/termux-pacman/termux-packages/releases/latest/download/bootstrap-aarch64.zip'
unzip -v tqs.zip && rm -f tqs.zip
cat SYMLINKS.txt | awk -F "←" '{system("ln -sv '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'
rm -f SYMLINKS.txt
cd ..
rm -rf "${PREFIX}"
mv ./tqs "${PREFIX}"
rm -rf "${HOME}"
