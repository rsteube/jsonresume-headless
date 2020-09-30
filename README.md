# jsonresume-headless

Just another docker container for [resume-cli](https://github.com/jsonresume/resume-cli), but with headless chrome for pdf export.

## Getting Started 

Save the following as executable script to your PATH (e.g. `~/.local/bin/resume-cli`):
```sh
#!/bin/sh

docker run --init --rm -p 4000:4000 -u $(id -u):$(id -g) -v "$(pwd):/work" -it rsteube/jsonresume-headless $@
```

then use just as if native:
```sh
resume-cli export --theme classy resume.pdf
```
