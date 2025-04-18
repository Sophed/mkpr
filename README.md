# mkpr — make project
Fast Zig CLI tool to create projects from a set of opinionated language templates

![CLI tool showcase](demo.png)

## Usage
`mkpr <template> <project-name>`
- Use `mkpr ls` for a list of templates

## Motive
Originally based on my project [golaunch](https://github.com/Sophed/golaunch), mkpr is intended to be a comprehensive set of utility scripts and templates for my personal projects.

Just was chosen as the action runner of choice for its flexibility and simple shell-like syntax. Running `just build` and having a cohesive toolchain is far simpler than having build scripts with different syntax for each language I use for a project.

## Installing
- I'll add to some package repos eventually
- Until then, there is binaries available in [releases](https://github.com/Sophed/mkpr/releases)

## Building
- Requires `zig` version **0.13.0** and `just` installed
```
git clone https://github.com/Sophed/mkpr
cd mkpr
just build
```
- Output binaries can be found in `zig-out/bin/`