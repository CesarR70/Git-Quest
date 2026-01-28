#!/bin/bash

# ============================================================================
# VALIDATOR LIBRARY
# Validates user git command inputs and provides feedback
# ============================================================================

# Source dependencies if not already sourced
if [[ -z "$NC" ]]; then
    source "$(dirname "$0")/colors.sh"
fi

# ============================================================================
# COMMAND VALIDATION
# ============================================================================

# Validate if input matches expected command (with flexibility)
# Supports wildcards (*) in expected_cmd for partial matching
# Returns 0 if matches, 1 if not
validate_command() {
    local user_input="$1"
    local expected_cmd="$2"
    
    # Normalize inputs - remove extra spaces
    user_input=$(echo "$user_input" | xargs)
    expected_cmd=$(echo "$expected_cmd" | xargs)
    
    # Exact match
    if [[ "$user_input" == "$expected_cmd" ]]; then
        return 0
    fi
    
    # Check if expected_cmd contains wildcards for pattern matching
    if [[ "$expected_cmd" == *"*"* ]]; then
        # Build regex pattern first, THEN remove quotes from both for comparison
        local pattern="$expected_cmd"
        local user_input_clean="$user_input"
        
        # Build regex pattern by escaping special chars and converting * to wildcard
        local regex_pattern=""
        local i=0
        while [[ $i -lt ${#pattern} ]]; do
            local char="${pattern:$i:1}"
            if [[ "$char" == "*" ]]; then
                regex_pattern="${regex_pattern}.*"
            else
            # Escape regex special characters
            case "$char" in
                '.'|'['|']'|'\\'|'('|')'|'+'|'?'|'{'|'}'|'|'|'^'|'$')
                    regex_pattern="${regex_pattern}\\${char}"
                    ;;
                *)
                    regex_pattern="${regex_pattern}${char}"
                    ;;
            esac
            fi
            ((i++))
        done
        
        # Now remove ALL quotes from both for comparison
        user_input_clean="${user_input_clean//\'/}"
        user_input_clean="${user_input_clean//\"/}"
        
        # Also remove surrounding wildcards from pattern to allow flexible matching
        # If pattern is "*message*", match just "message" anywhere in input
        
        if [[ "$regex_pattern" =~ ^\.\*(.+)\.\*$ ]]; then
            # Pattern is *something*, match that something anywhere
            local match_content="${BASH_REMATCH[1]}"
            if [[ "$user_input_clean" == *"$match_content"* ]]; then
                return 0
            fi
        elif [[ "$user_input_clean" =~ ^${regex_pattern}$ ]]; then
            return 0
        fi
    fi
    
    # Check if it starts with the expected command
    if [[ "$user_input" == "$expected_cmd "* ]] || [[ "$user_input" == "$expected_cmd" ]]; then
        return 0
    fi
    
    return 1
}

# Check if command contains a specific flag
has_flag() {
    local user_input="$1"
    local flag="$2"
    
    if [[ "$user_input" == *"$flag"* ]]; then
        return 0
    fi
    return 1
}

# ============================================================================
# SPECIFIC COMMAND VALIDATORS
# ============================================================================

# Validate git init
validate_git_init() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # Exact match or just "git init"
    if [[ "$normalized" == "git init" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git add
validate_git_add() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # Check for git add with various targets
    if [[ "$normalized" == "git add"* ]]; then
        # Check they provided a target
        local after_git_add="${normalized#git add}"
        after_git_add=$(echo "$after_git_add" | xargs)
        
        if [[ -n "$after_git_add" ]]; then
            return 0
        fi
    fi
    
    return 1
}

# Validate git add .
validate_git_add_dot() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git add ." ]]; then
        return 0
    fi
    
    return 1
}

# Validate git add <file>
validate_git_add_file() {
    local input="$1"
    local expected_file="$2"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    local normalized_file=$(echo "$expected_file" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git add $normalized_file" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git commit
validate_git_commit() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # Normalize double-dashes to single-dashes for comparison
    # git allows both --flag and -flag (short form)
    local normalized_nodash="${normalized//---/-}"
    
    # Must have commit command with -m flag (or --m for --amend)
    if [[ "$normalized" == "git commit"* ]] && [[ "$normalized" == *"-m"* ]]; then
        return 0
    fi
    
    # Also accept --amend form
    if [[ "$normalized" == "git commit --amend"* ]] || [[ "$normalized" == "git commit -amend"* ]]; then
        return 0
    fi
    
    # Accept --allow-empty form
    if [[ "$normalized" == "git commit --allow-empty"* ]] || [[ "$normalized" == "git commit -allow-empty"* ]]; then
        return 0
    fi
    
    return 1
}

# Validate git commit with message
validate_git_commit_msg() {
    local input="$1"
    local expected_msg="$2"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git commit"* ]] && [[ "$normalized" == *"-m"* ]]; then
        # Check if message matches (partially)
        local msg_placeholder=$(echo "$expected_msg" | tr '[:upper:]' '[:lower:]' | xargs)
        if [[ "$normalized" == *"$msg_placeholder"* ]]; then
            return 0
        fi
    fi
    
    return 1
}

# Validate git status
validate_git_status() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git status" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git log
validate_git_log() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git log" ]]; then
        return 0
    fi
    
    # Also accept git log --oneline
    if [[ "$normalized" == "git log --oneline" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git push
validate_git_push() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # Accept just "git push" (after upstream is set)
    if [[ "$normalized" == "git push" ]]; then
        return 0
    fi
    
    # Accept "git push -u origin main" (first push, sets tracking)
    if [[ "$normalized" == "git push -u origin main" ]]; then
        return 0
    fi
    
    # Accept "git push origin main" (without -u)
    if [[ "$normalized" == "git push origin main" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git branch
validate_git_branch() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # git branch (list branches)
    if [[ "$normalized" == "git branch" ]]; then
        return 0
    fi
    
    # git branch <name> (create branch)
    if [[ "$normalized" == "git branch "* ]]; then
        local after_branch="${normalized#git branch }"
        after_branch=$(echo "$after_branch" | xargs)
        if [[ -n "$after_branch" ]]; then
            return 0
        fi
    fi
    
    return 1
}

# Validate git branch <name>
validate_git_branch_name() {
    local input="$1"
    local expected_name="$2"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    local normalized_name=$(echo "$expected_name" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git branch $normalized_name" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git checkout
validate_git_checkout() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git checkout"* ]]; then
        return 0
    fi
    
    return 1
}

# Validate git checkout -b (create and switch)
validate_git_checkout_b() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git checkout -b"* ]]; then
        return 0
    fi
    
    return 1
}

# Validate git merge
validate_git_merge() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git merge"* ]]; then
        return 0
    fi
    
    return 1
}

# Validate git merge <branch>
validate_git_merge_branch() {
    local input="$1"
    local expected_branch="$2"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    local normalized_branch=$(echo "$expected_branch" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git merge $normalized_branch" ]]; then
        return 0
    fi
    
    return 1
}

# ============================================================================
# FEEDBACK FUNCTIONS
# ============================================================================

# Get hint for a command
get_hint() {
    local expected_cmd="$1"
    
    case "$expected_cmd" in
        "git init")
            echo "Try: git init"
            ;;
        "git add")
            echo "Use: git add <filename> or git add . (to add all files)"
            ;;
        "git commit")
            echo "Remember the -m flag with a message: git commit -m 'message'"
            ;;
        "git status")
            echo "Just type: git status"
            ;;
        "git log")
            echo "Just type: git log"
            ;;
        "git push")
            echo "Use: git push origin main"
            ;;
        "git branch")
            echo "Use: git branch <branch-name> to create a new branch"
            ;;
        "git checkout")
            echo "Use: git checkout <branch-name> to switch branches"
            ;;
        "git merge")
            echo "Use: git merge <branch-name> to merge a branch into current"
            ;;
        "git log --oneline")
            echo "Use: git log --oneline"
            ;;
        "git log --graph")
            echo "Try combining it with --oneline: git log --graph --oneline"
            ;;
        "git checkout -b")
            echo "Use: git checkout -b <branch-name> to create and switch"
            ;;
        "git branch")
            echo "Use: git branch to list branches, or git branch <name> to create"
            ;;
        "git show")
            echo "Use: git show to see the latest commit details"
            ;;
        "git diff")
            echo "Use: git diff to see unstaged changes"
            ;;
        "git stash")
            echo "Use: git stash to temporarily save changes"
            ;;
        *)
            echo "Think about what the task is asking for..."
            ;;
    esac
}

# ============================================================================
# SPECIAL VALIDATORS
# ============================================================================

# Check if input is the right command type (e.g., correct verb but wrong details)
check_command_type() {
    local input="$1"
    local expected_verb="$2"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # Check if it starts with the right git command
    if [[ "$normalized" == "$expected_verb"* ]]; then
        return 0
    fi
    
    return 1
}

# Check if user is close but missed something
analyze_near_miss() {
    local input="$1"
    local expected="$2"
    
    # Missing -m flag for commit
    if [[ "$expected" == "git commit"* ]] && [[ "$input" == "git commit" ]]; then
        echo "You forgot the -m flag with a message!"
        return 0
    fi
    
    # Missing target for add
    if [[ "$expected" == "git add"* ]] && [[ "$input" == "git add" ]]; then
        echo "You need to specify which file to add!"
        return 0
    fi
    
    return 1
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

# Show fake git init output
show_fake_git_init() {
    echo -e "${GREEN}Initialized empty Git repository in /tmp/my-project/.git/${NC}"
}

# Show fake git add output
show_fake_git_add() {
    echo -e "${GREEN}(no output - success!)${NC}"
}

# Show fake git commit output
show_fake_git_commit() {
    local msg="$1"
    cat << EOF
[main (root-commit) 1234567] $msg
 1 file changed, 1 insertion(+)
 create mode 100644 index.html
EOF
}

# Show fake git status output
show_fake_git_status() {
    cat << 'EOF'
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
EOF
}

# Show fake git status with changes
show_fake_git_status_changes() {
    cat << 'EOF'
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   index.html

no changes added to commit (use "git add" or "git commit -a")
EOF
}

# Show fake git log output
show_fake_git_log() {
    cat << 'EOF'
commit 1234567890abcdef1234567890abcdef12345678 (HEAD -> main)
Author: Developer <dev@example.com>
Date:   Mon Jan 2 15:30:00 2026 -0500

    Add initial project files

commit 0987654321fedcba0987654321fedcba09876543
Author: Developer <dev@example.com>
Date:   Mon Jan 2 14:00:00 2026 -0500

    Initial commit
EOF
}

# Show fake git branch output
show_fake_git_branch() {
    cat << 'EOF'
* main
EOF
}

# Show fake git branch with feature branch
show_fake_git_branch_multi() {
    cat << 'EOF'
  feature/login
* main
EOF
}

# Show fake git merge output
show_fake_git_merge() {
    cat << 'EOF'
Updating 1234567..2345678
Fast-forward
 index.html | 2 ++
 1 file changed, 2 insertions(+)
EOF
}

# ============================================================================
# REMOTE COMMANDS
# ============================================================================

# ============================================================================
# ADVANCED COMMAND VALIDATORS (for chapters 10-17)
# ============================================================================

# Validate git reset
validate_git_reset() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git reset"* ]]; then
        return 0
    fi
    
    return 1
}

# Validate git stash
validate_git_stash() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git stash" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git show
validate_git_show() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git show" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git log --oneline
validate_git_log_oneline() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # Accept exact match or with additional spaces
    if [[ "$normalized" == "git log --oneline" ]]; then
        return 0
    fi
    
    # Also accept with extra spaces around --oneline flag
    if [[ "$normalized" == "git log --oneline "* ]] || [[ "$normalized" == "git log --oneline" ]]; then
        return 0
    fi
    
    # Accept variations like "git log --oneline" 
    if [[ "$normalized" == "git log --oneline"* ]]; then
        return 0
    fi
    
    return 1
}

# Validate git rebase
validate_git_rebase() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git rebase"* ]]; then
        return 0
    fi
    
    return 1
}

# Validate git branch creation (more specific)
validate_git_branch_create() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git branch "* ]]; then
        local after_branch="${normalized#git branch }"
        after_branch=$(echo "$after_branch" | xargs)
        if [[ -n "$after_branch" ]]; then
            return 0
        fi
    fi
    
    return 1
}

# Validate git branch list
validate_git_branch_list() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    if [[ "$normalized" == "git branch" ]]; then
        return 0
    fi
    
    return 1
}

# Validate git remote
validate_git_remote() {
    local input="$1"
    local normalized=$(echo "$input" | xargs | tr '[:upper:]' '[:lower:]')
    
    # Check for git remote add origin <url>
    if [[ "$normalized" == "git remote add origin"* ]] && ([[ "$normalized" == *"http"* ]] || [[ "$normalized" == *"https"* ]] || [[ "$normalized" == *"git@"* ]]); then
        return 0
    fi
    
    return 1
}

# ============================================================================
# ADVANCED COMMAND SIMULATION (for chapters 10-17)
# ============================================================================

# Show fake git reset output
show_fake_git_reset() {
    cat << 'EOF'
Unstaged changes after reset:
  (use "git add <file>..." to update what will be committed)
	modified:   test.txt
EOF
}

# Show fake git stash output
show_fake_git_stash() {
    cat << 'EOF'
Saved working directory and index state WIP on main: a1b2c3d Add initial content
EOF
}

# Show fake git show output
show_fake_git_show() {
    cat << 'EOF'
commit a1b2c3d
Author: Git Quest <gitquest@example.com>
Date:   Mon Jan 1 12:00:00 2026 -0000

    Add new line

diff --git a/show.txt b/show.txt
index 1234567..89abcde 100644
--- a/show.txt
+++ b/show.txt
@@ -1,2 +1,3 @@
 This is the first line.
 This is the second line.
+This is a new line.
EOF
}

# Show fake git log --oneline output
show_fake_git_log_oneline() {
    cat << 'EOF'
a1b2c3d Add new line
e4f5g6h Add initial content
EOF
}

# Show fake git branch creation output
show_fake_git_branch_create() {
    cat << 'EOF'
Switched to a new branch 'feature-branch'
EOF
}

# Show fake git branch list output
show_fake_git_branch_list() {
    cat << 'EOF'
  feature-branch
* main
EOF
}

# Show fake git rebase output
show_fake_git_rebase() {
    cat << 'EOF'
First, rewinding head to replay your work on top of it...
Applying: Add initial content
Applying: Minor change
Applying: Another change
EOF
}

# Show fake git remote output
show_fake_git_remote() {
    cat << 'EOF'
origin  https://github.com/user/repo.git (fetch)
origin  https://github.com/user/repo.git (push)
EOF
}

# Show fake git push output
show_fake_git_push() {
    cat << 'EOF'
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 304 bytes | 304 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/user/repo.git
 * [new branch]      main -> main
EOF
}

# Show fake git checkout output
show_fake_git_checkout() {
    local branch_name="$1"
    cat << EOF
Switched to branch '$branch_name'
EOF
}