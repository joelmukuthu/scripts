## Expanded on from @gustavnikolaj's work from
## https://github.com/gustavnikolaj/dotfiles/blob/bf88fedbd01eef57dd8bc422fe7ec7e03e397a56/bash/bash.d/p.sh

export PROJECTS_DIR=~/Projects
export GAN_PROJECTS_DIR=~/Projects/@ganintegrity
export KNORM_PROJECTS_DIR=~/Projects/@knorm
export UNEXPECTED_PROJECTS_DIR=~/Projects/@unexpected
export PHOOK_CD=p_set_title:$PHOOK_CD

function p_set_title() {
    printf "\033]0;%s\007" `basename $1` # Set the terminal title
}

function p_cd() {
    cd $1
    if [ "$PHOOK_CD" != "" ] ; then
        local mails=$(echo $PHOOK_CD | tr ":" "\n")
        for hook in $mails; do eval $hook $1 ; done
    fi
}

function p_find() {
    if [ -z $2 ]; then
        # If no second argument, go to the projects' dir
        cd $1
    else
        # Find all folders in the projects' dir
        local projects="`find $1 -mindepth 1 -maxdepth 1 -type d -exec basename {} \;`"

        # For each argument, grep for folders that match that argument in the
        # remaining folders
        local argument_count=$#
        local arguments=("$@")
        for (( j=1; j<argument_count; j++ )); do
            local projects="`echo "$projects" | grep "${arguments[j]}"`"
        done

        # Sort the directories by length
        local projects="`echo "$projects" | awk '{print length, $0}' | sort -n | cut -d " " -f2-`"

        # Go to the first folder in the filtered list of folders
        local destination=`echo "$projects" | head -n 1`
        if [ -z $destination ]; then
            # If we dont have a match use z to try to make a guess of what you meant
            # and if the z command is not defined, just go to the projects dir.
            if [ -z "`type -t z`" ]; then
                p_cd $1
            else
                local z_guess=$(z -e $@)
                if [ -z $z_guess ] ; then
                    echo "No match for: $@"
                else
                    echo "Jumping to z-match: $z_guess"
                    p_cd $z_guess
                fi
            fi
        else
            p_cd $1/$destination
        fi
    fi
}

function _p_projects_complete_() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local projectdirs=$(find $PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$projectdirs" -- "${word}"))
}

function _k_projects_complete_() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local projectdirs=$(find $KNORM_PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$projectdirs" -- "${word}"))
}

function _g_projects_complete_() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local projectdirs=$(find $GAN_PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$projectdirs" -- "${word}"))
}

function _u_projects_complete_() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local projectdirs=$(find $UNEXPECTED_PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$projectdirs" -- "${word}"))
}

function p() {
    p_find $PROJECTS_DIR "$@"
}

function k() {
    p_find $KNORM_PROJECTS_DIR "$@"
}

function g() {
    p_find $GAN_PROJECTS_DIR "$@"
}

function u() {
    p_find $UNEXPECTED_PROJECTS_DIR "$@"
}

complete -F _p_projects_complete_ p
complete -F _k_projects_complete_ k
complete -F _g_projects_complete_ g
complete -F _u_projects_complete_ u