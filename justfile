play := GREEN + BOLD + "󰐊 "
hammer := GREEN + BOLD + "󰣪 "
check := GREEN + BOLD + "󰄬 "
flask := GREEN + BOLD + "󰂔 "

run *ARGS:
    @echo -e "{{play}}running project...{{NORMAL}}"
    @zig build run -- {{ARGS}}

build:
    @echo -e "{{hammer}}building project...{{NORMAL}}"
    @zig build
    @echo -e "{{check}}successfully built to ./zig-out/{{NORMAL}}"

build-all:
    @echo -e "{{hammer}}building project for major platforms...{{NORMAL}}"

    @zig build -Dtarget="x86_64-linux"
    @echo -e "{{check + NORMAL}}built for linux-x86"

    @zig build -Dtarget="aarch64-linux"
    @echo -e "{{check + NORMAL}}built for linux-aarch64"

    @zig build -Dtarget="x86_64-macos"
    @echo -e "{{check + NORMAL}}built for macos-x86_64"

    @zig build -Dtarget="aarch64-macos"
    @echo -e "{{check + NORMAL}}built for macos-aarch64"

    @echo -e "{{check}}successfully built binaries to ./zig-out/bin/{{NORMAL}}"

test:
    @echo -e "{{flask}}testing project...{{NORMAL}}"
    @zig build test
    @echo -e "{{check}}tests passed{{NORMAL}}"