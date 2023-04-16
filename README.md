# dev-setup

Files and scripts for me to run when setting up a new system

## Setup

1. Install [fleek and Nix](https://getfleek.dev/docs/installation)
2. Copy `./fleek.yml` to `~/.fleek.yml` 
3. Run `fleek apply`

If all went well all of the fleek packages should now be available!

### Trouble Shooting Fleek

At the moment hostnames seem kind of wonky and will just change. I suspect this is partly to do with changing networks (i.e. WiFi, ethernet, hotspot).

If this happens `fleek apply` will fail. The fix at the moment is as follows:

1. Get your current hostname by running `hostname`.
2. Rename the `hostname` line in `.fleek.yml` to this new hostname.
  - Pay attention to the old hostname, we'll need it later!
3. Run `fleeks` to navigate to your fleek setup.
4. Copy the directory named after the previous hostname to a directory named after the current hostname.
5. Run `fleek apply`.

## Global NPM packages

Because fleek packages are deterministic it will get mad if you try to install global NPM packages by default.

To fix this add the following:

1. Create/edit the file `~/.npmrc`.
2. Add the line `prefix = ${HOME}/.npm-packages`.
  - This is telling NPM where to install global packages.
3. In `~/.zshrc` add the following:
  - `export PATH=~/.npm-packages/bin:$PATH`
  - `export NODE_PATH=~/.npm-packages/lib/node_modules`

## Trouble Shooting Tmux

If the delete key in tmux isn't working do the following:

1. Create/edit the file ~/.tmux.conf
2. Add the line `set -g default-terminal "xterm-256color"`.
3. Run `tmux kill-server` to restart the server.
