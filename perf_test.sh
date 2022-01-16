#!/usr/bin/env bash

# Script to test performance of different approach
KEEPASS_FG="0;0;0"
KEEPASS_BG="255;255;255"
SHELL="/bin/bash"

info_line_fg["keepass"]="${KEEPASS_FG}"
info_line_bg["keepass"]="${KEEPASS_BG}"
nb_test=10

array_access()
{
    idx_segment="keepass"
    for (( i=0; i<${nb_test};i++))
    do
        segment_bg="${CLR_PREFIX}${CLR_BG_PREFIX}${info_line_bg[idx_segment]}${CLR_SUFFIX}"
        segment_clr_switch="${CLR_PREFIX}${CLR_FG_PREFIX}${info_line_bg[idx_segment]}${CLR_SUFFIX}"
        segment_fg="${CLR_PREFIX}${CLR_FG_PREFIX}${info_line_fg[idx_segment]}${CLR_SUFFIX}"
    done
}

string_substitution()
{
    idx_segment="keepass"
    for (( i=0; i<${nb_test};i++))
    do
        case ${SHELL} in
          *bash)
            segment_bg="${idx_segment^^}_BG"
            segment_clr_switch="${CLR_PREFIX}${CLR_FG_PREFIX}${!segment_bg}${CLR_SUFFIX}"
            segment_bg="${CLR_PREFIX}${CLR_BG_PREFIX}${!segment_bg}${CLR_SUFFIX}"
            segment_fg="${idx_segment^^}_FG"
            segment_fg="${CLR_PREFIX}${CLR_FG_PREFIX}${!segment_fg}${CLR_SUFFIX}"
            ;;
          *zsh)
            segment_bg="${idx_segment:u}_BG"
            segment_clr_switch="${CLR_PREFIX}${CLR_FG_PREFIX}${(P)segment_bg}${CLR_SUFFIX}"
            segment_bg="${CLR_PREFIX}${CLR_BG_PREFIX}${(P)segment_bg}${CLR_SUFFIX}"
            segment_fg="${idx_segment:u}_FG"
            segment_fg="${CLR_PREFIX}${CLR_FG_PREFIX}${(P)segment_fg}${CLR_SUFFIX}"
            ;;
        esac
    done
}

echo "=============================="
time array_access
time string_substitution

# Inspired by
# https://stackoverflow.com/questions/2559076/how-do-i-redirect-output-to-a-variable-in-shell
search_bashism_regex_1()
{
    if [[ "${array_test[*]}" =~ "${text_to_search}" ]]
    then
        echo "==regex_1==found!"
    fi
}

search_bashism_regex_2()
{
    if [[ "${array_test[@]}" =~ "${text_to_search}" ]]
    then
        echo "==regex_2==found!"
    fi
}

search_grep_1()
{
    if echo "${array_test[*]}" | grep -qF "$text_to_search"
    then
        echo "==grep_1==found!"
    fi
}

search_grep_2()
{
    if echo "${array_test[@]}" | grep -qF "$text_to_search"
    then
        echo "==grep_2==found!"
    fi
}

search_grep_ifs_1()
{
    if (IFS=$'\n'; echo "${array_test[*]}" ) | grep -qFx "$text_to_search"
    then
        echo "==ifs_1==found!"
    fi
}

search_grep_ifs_2()
{
    if (IFS=$'\n'; echo "${array_test[@]}" ) | grep -qFx "$text_to_search"
    then
        echo "==ifs_2==found!"
    fi
}


size=$((10 ** 7))
array_test=($(seq -f 'text%.0f' 1 "$size"))
text_to_search="text$size"
echo "=============================="
time search_bashism_regex_1
time search_bashism_regex_2
time search_grep_1
time search_grep_2
time search_grep_ifs_1
time search_grep_ifs_2

size=100
array_test=($(seq -f 'text%.0f' 1 "$size"))
text_to_search="text$size"
echo "=============================="
time search_bashism_regex_1
time search_bashism_regex_2
time search_grep_1
time search_grep_2
time search_grep_ifs_1
time search_grep_ifs_2
