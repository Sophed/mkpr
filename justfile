run *ARGS:
    @echo -e "\e[1;32m󰐊 running project...\033[0m"
    @zig build -p ./zig-out
    @./zig-out/bin/* {{ARGS}}

build:
    @echo -e "\e[1;32m󰣪 building project...\033[0m"
    @zig build -p ./zig-out
    @echo -e "\e[1;32m󰄬 successfully built to ./zig-out/\033[0m"

build-all:
    @echo -e "\e[1;32m󰣪 building project for major platforms...\033[0m"

    @zig build -Dtarget="x86_64-linux" -p ./zig-out/
    @mv ./zig-out/bin/mkpr ./zig-out/bin/mkpr-linux-x86_64
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for x86_64-linux"

    @zig build -Dtarget="aarch64-linux" -p ./zig-out/
    @mv ./zig-out/bin/mkpr ./zig-out/bin/mkpr-linux-aarch64
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for aarch64-linux"

    @zig build -Dtarget="x86_64-macos" -p ./zig-out/
    @mv ./zig-out/bin/mkpr ./zig-out/bin/mkpr-macos-x86_64
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for x86_64-macos"

    @zig build -Dtarget="aarch64-macos" -p ./zig-out/
    @mv ./zig-out/bin/mkpr ./zig-out/bin/mkpr-macos-aarch64
    @echo -e "\e[1;32m󰄬 \033[0mbuilt for aarch64-macos"

    @echo -e "\e[1;32m󰄬 successfully built to ./zig-out/\033[0m"