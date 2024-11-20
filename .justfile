install:
  #!/bin/sh
  tempfile=$(mktemp)
  curl -o ${tempfile} https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
  tic -x -o ~/.terminfo ${tempfile}
  rm -f ${tempfile}

update: && build-bat-cache
  stow --verbose --target=$HOME --restow */

build-bat-cache:
  bat cache --build
