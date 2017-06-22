# scripts

Just some collection of bash scripts.

#### hali
shows weather from [wttr.in](http://wttr.in) in the terminal.

#### git-purge-local-branches
deletes local branches that have been deleted remotely

#### list-installed
lists packages that you have intentionally installed with `apt-get install`,
excluding those that might have been installed as dependencies.

#### conditional-pidgin
this one documents itself :)

#### p
enhanced `cd`. ripped from https://github.com/gustavnikolaj/dotfiles.

#### load-nvmrc
loads the node version set through a local `.nvmrc` and defaults to the default
node version. also from https://github.com/gustavnikolaj/dotfiles.

Sample `.bashrc`:

```bash
. ~/Projects/scripts/hali.sh
. ~/Projects/scripts/git-purge-local-branches.sh
. ~/Projects/scripts/list-installed.sh
. ~/Projects/scripts/p.sh
. ~/Projects/scripts/nr.sh
. ~/Projects/scripts/load-nvmrc.sh

export PHOOK_CD=$PHOOK_CD:load-nvmrc # set up hook for p

load-nvmrc # attempt to load appropriate node version
hali # show some weather!
```
