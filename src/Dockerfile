FROM nimlang/nim

run git clone https://github.com/enthus1ast/nimvatar.git
run cd nimvatar
run nimble install
run cd nimvatar/src
run nim c -d:release --opt:speed -d:lto server.nim


# ENTRYPOINT ["./server"]