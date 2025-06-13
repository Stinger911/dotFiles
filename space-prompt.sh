#!/bin/bash
# ANSI color codes
C_RESET="\[\033[0m\]"
C_GREEN="\[\033[0;31m\]"
C_YELLOW="\[\033[0;33m\]"
C_CYAN="\[\033[0;36m\]"
C_MAGENTA="\[\033[0;35m\]"
C_UP="↑"
C_DOWN="↓"
C_BOTH="↕︎"
C_CLEAN="≡"
C_BRANCH=""
C_PROMPT="❯"
# Function to get Git branch name and state
_git_branch_info() {
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -z "$branch_name" ]; then
        echo "" # Not in a git repository
        return
    fi

    local upstream_info=$(git status -sb 2>/dev/null | head -n 1)
    local branch_state=""

    if [[ "$upstream_info" =~ \[ahead\ ([0-9]+)\] ]]; then
        local ahead_count=${BASH_REMATCH[1]}
        branch_state="${C_UP}$ahead_count"
    fi

    if [[ "$upstream_info" =~ \[behind\ ([0-9]+)\] ]]; then
        local behind_count=${BASH_REMATCH[1]}
        if [ -n "$branch_state" ]; then
            branch_state="${C_BOTH}($ahead_count/$behind_count)"
        else
            branch_state="${C_DOWN}$behind_count"
        fi
    fi

    if [ -z "$branch_state" ]; then
        branch_state="${C_CLEAN}"
    fi

    echo "$branch_name $branch_state"
}

# Function to get Git file statuses
_git_status_info() {
    local staged_info=""
    local working_info=""

    local status=$(git status --porcelain 2>/dev/null)
    if [ -z "$status" ]; then
        echo "" # Not in a git repository or no changes
        return
    fi

    local created_staged=0
    local modified_staged=0
    local deleted_staged=0
    local untracked_working=0
    local created_working=0
    local modified_working=0
    local deleted_working=0

    while IFS= read -r line; do
        case "${line:0:2}" in
            "A ") ((created_staged++)) ;; # Staged: Added
            "M ") ((modified_staged++)) ;; # Staged: Modified
            "D ") ((deleted_staged++)) ;; # Staged: Deleted
            " M") ((modified_working++)) ;; # Working: Modified
            " D") ((deleted_working++)) ;; # Working: Deleted
            "??") ((untracked_working++)) ;; # Untracked
            "AM") ((created_staged++)); ((modified_working++)) ;; # Staged A, Working M (rare but possible)
            "MM") ((modified_staged++)); ((modified_working++)) ;; # Staged M, Working M
            "DD") ((deleted_staged++)); ((deleted_working++)) ;; # Staged D, Working D
            "A ") ((created_staged++)) ;; # Staged: Added
            "D ") ((deleted_staged++)) ;; # Staged: Deleted
            "R ") ((modified_staged++)) ;; # Staged: Renamed (count as modified for simplicity)
            "C ") ((modified_staged++)) ;; # Staged: Copied (count as modified for simplicity)
            " M") ((modified_working++)) ;; # Working: Modified
            " D") ((deleted_working++)) ;; # Working: Deleted
            " U") ((modified_working++)) ;; # Working: Untracked or updated but unmerged
            "UU") ((modified_working++)) ;; # Unmerged
            "??") ((untracked_working++)) ;; # Untracked
        esac
    done <<< "$status"

    if (( created_staged + modified_staged + deleted_staged > 0 )); then
        staged_info="staged:"
        if (( created_staged > 0 )); then staged_info+=" +$created_staged"; fi
        if (( modified_staged > 0 )); then staged_info+=" ~$modified_staged"; fi
        if (( deleted_staged > 0 )); then staged_info+=" -$deleted_staged"; fi
    fi

    if (( created_working + modified_working + deleted_working + untracked_working > 0 )); then
        working_info="working:"
        if (( created_working > 0 )); then working_info+=" +$created_working"; fi
        if (( modified_working > 0 )); then working_info+=" ~$modified_working"; fi
        if (( deleted_working > 0 )); then working_info+=" -$deleted_working"; fi
        if (( untracked_working > 0 )); then working_info+=" ?$untracked_working"; fi
    fi

    echo "$staged_info $working_info"
}

# Main function to set the prompt
_set_git_prompt() {
    local username="\u"
    local current_dir="\w" # Full path
    local tilde_based_dir="${current_dir/#$HOME/\~}" # Replace $HOME with ~

    local git_info=$(_git_branch_info)
    local branch_name=""
    local branch_state=""

    if [ -n "$git_info" ]; then
        read -r branch_name branch_state <<< "$git_info"
    fi

    local git_status=$(_git_status_info)
    local staged_status=""
    local working_status=""

    # Split git_status into staged_status and working_status
    if [ -n "$git_status" ]; then
        # Use awk to split the string based on 'working:'
        if [[ "$git_status" =~ (staged:.*)(working:.*) ]]; then
            staged_status="${BASH_REMATCH[1]}"
            working_status="${BASH_REMATCH[2]}"
        elif [[ "$git_status" =~ (staged:.*) ]]; then
            staged_status="${BASH_REMATCH[1]}"
        elif [[ "$git_status" =~ (working:.*) ]]; then
            working_status="${BASH_REMATCH[1]}"
        fi
    fi

    # Construct the prompt string with colors
    local prompt_str=""
    prompt_str+="${C_YELLOW}${username}${C_RESET} in "
    prompt_str+="${C_CYAN}${tilde_based_dir}${C_RESET}"

    if [ -n "$branch_name" ]; then
        prompt_str+=" on ${C_MAGENTA}${C_BRANCH} ${branch_name}"
        if [ -n "$branch_state" ]; then
            prompt_str+=" (${branch_state})"
        fi
    fi

    if [ -n "$staged_status" ]; then
        prompt_str+=" %[${staged_status}]"
    fi

    if [ -n "$working_status" ]; then
        prompt_str+=" *[${working_status}]"
    fi
    prompt_str+="${C_RESET}"

    export PS1="${prompt_str}\n\${C_GREEN}${C_PROMPT}${C_RESET} " # Add a newline and then the traditional $ or #
}

# Set PROMPT_COMMAND to execute _set_git_prompt before each prompt
export PROMPT_COMMAND="_set_git_prompt; $PROMPT_COMMAND"
