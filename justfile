run *ARGS:
    @echo -e "\e[1;32m󰐊 running project...\033[0m"
    @zig build run -- {{ARGS}}

build:
    @echo -e "\e[1;32m󰣪 building project...\033[0m"
    @zig build
    @echo -e "\e[1;32m󰄬 successfully built to ./zig-out/\033[0m"

build-all:
    @echo -e "\e[1;32m󰣪 building project for major platforms...\033[0m"

    @zig build -Dtarget="x86_64-linux"
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for linux-x86"

    @zig build -Dtarget="aarch64-linux"
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for linux-aarch64"

    @zig build -Dtarget="x86_64-macos"
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for macos-x86_64"

    @zig build -Dtarget="aarch64-macos"
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for macos-aarch64"

    @echo -e "\e[1;32m󰄬 successfully built binaries to ./zig-out/bin/\033[0m"

test:
    @echo -e "\e[1;32m󰂔 testing project...\033[0m"
    @zig build test
    @echo -e "\e[1;32m󰄬 tests passed\033[0m"