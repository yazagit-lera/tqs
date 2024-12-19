#!/system/bin/env sh

mkdir -p tqs
cd tqs
curl -ZLo tqs.zip 'https://github.com/termux/termux-packages/releases/latest/download/bootstrap-aarch64.zip'
unzip tqs.zip
cat SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'
rm -f tqs.zip SYMLINKS.txt
cd ..
rm -rf "$PREFIX"
mv ./nusr "$PREFIX"
