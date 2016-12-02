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

Sample `.bashrc`:

```bash
. ~/Projects/scripts/hali.sh
. ~/Projects/scripts/git-purge-local-branches.sh
. ~/Projects/scripts/list-installed.sh
. ~/Projects/scripts/p.sh

load-nvmrc() {
    if [ -f .nvmrc ] ; then
        nvm use || nvm install
    elif [[ $(nvm version) != $(nvm version default) ]] ; then
        echo "nvm: Reverting to default node version."
        nvm use default
    fi
}

load-nvmrc # attempt to load appropriate node version

export PHOOK_CD=$PHOOK_CD:load-nvmrc # set up hook for p

hali # show some weather!
```
