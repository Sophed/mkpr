run *ARGS:
    @echo -e "\e[1;32m󰐊 running project...\033[0m"
    @zig build -p ./zig-out
    @./zig-out/bin/* {{ARGS}}

build:
    @echo -e "\e[1;32m󰣪 building project...\033[0m"
    @zig build -p ./zig-out
    @echo -e "\e[1;32m󰄬 successfully built to ./zig-out/\033[0m"