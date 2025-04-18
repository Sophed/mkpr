run *ARGS:
    @echo -e "\e[1;32m󰐊 running project...\033[0m"
    @go run ./app {{ARGS}}

build:
    @echo -e "\e[1;32m󰣪 building project...\033[0m"
    @rm -rf ./build
    @go build -o ./build/bin ./app
    @echo -e "\e[1;32m󰄬 successfully built to ./build/bin\033[0m"

test:
    @echo -e "\e[1;32m󰂔 testing project...\033[0m"
    @go test ./...
    @echo -e "\e[1;32m󰄬 tests passed\033[0m"