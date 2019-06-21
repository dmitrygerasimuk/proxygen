#/bin/bash
rm proxygen.app/Contents/MacOS/main
cp ../build/main proxygen.app/Contents/MacOS/
./fixdylibs.sh
