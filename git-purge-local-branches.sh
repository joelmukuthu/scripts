#!/bin/bash

# source: http://stackoverflow.com/a/28020809/5852444
function git-purge-local-branches() {
	git checkout master; \
		git  pull --rebase; \
		git  fetch --all -p; \
		git branch -vv | \
		grep ": gone]" | \
		awk '{ print $1 }' | \
		xargs -n 1 git branch -d
}
