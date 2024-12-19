#!/system/bin/env sh


mkdir nusr
cd nusr
curl -ZLo bs.zip 'https://github.com/termux/termux-packages/releases/latest/download/bootstrap-aarch64.zip'
unzip bs.zip
cat SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'
cd ..
rm -rf "$PREFIX"
mv ./nusr "$PREFIX"
