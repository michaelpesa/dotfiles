install: && build-bat-cache
  stow --verbose --target=$HOME --restow */

build-bat-cache:
  bat cache --build
