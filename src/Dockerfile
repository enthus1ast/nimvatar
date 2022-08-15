FROM nimlang/nim
run pwd
run git clone https://github.com/enthus1ast/nimvatar.git
workdir /nimvatar
run nimble install -y
workdir /nimvatar/src
run mkdir -p public/v1
run nim c -d:release --opt:speed -d:lto server.nim
CMD [/nimvatar/src/server]