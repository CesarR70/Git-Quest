#!/bin/bash

# ============================================================================
# DEPENDENCIES
# ============================================================================

# Source library modules for access to validation functions
CHAPTER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${CHAPTER_DIR}/../lib/colors.sh"
source "${CHAPTER_DIR}/../lib/ui.sh"
source "${CHAPTER_DIR}/../lib/narrator.sh"
source "${CHAPTER_DIR}/../lib/validator.sh"

# ============================================================================
# CHAPTER 15: Advanced Branching Techniques
# Learning: git branch -a, git branch -v, git checkout -b
# ============================================================================

chapter15_intro() {
    clear_screen
    narrator_chapter_intro 15 "Advanced Branching Techniques"
    
    cat << 'EOF'
🗣️  "Alright, branch Padawan! You've learned the basics, but 
    there's MORE to branches than just create/checkout/merge.
    
    Advanced commands:
    - git branch -a        = List ALL branches (including remote!)
    - git branch -v        = List branches with last commit info
    - git checkout -b      = Create AND switch in one command
    - git branch -m old new = Rename a branch
    
    Your task:
    Let's practice some advanced branch operations!"
EOF
    
    echo ""
    echo -e "${WHITE}First, let's see all your branches with details:${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git branch -v command
    if validate_command "$user_cmd" "git branch -v"; then
        show_fake_git_branch_v
        echo ""
        narrator_celebrate "SEE? You can see which commit each branch points to!"
        echo ""
        echo -e "${WHITE}Now create and switch to a new branch in ONE command:${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        if validate_git_checkout_b "$user_cmd"; then
            echo ""
            narrator_celebrate "Fancy! Created and switched in one command!"
            narrator_explain_advanced_branching
            
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        else
            # Retry checkout -b
            narrator_wrong_answer "$user_cmd" "git checkout -b <branch-name>"
            retry_checkout_b
            return 0
        fi
    else
        # Initial command wrong
        narrator_wrong_answer "$user_cmd" "git branch -v"
        retry_branch_v
        return 0
    fi
}

# Retry functions
retry_branch_v() {
    local attempts=0
    echo ""
    echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git branch -v"; then
            show_fake_git_branch_v
            echo ""
            narrator_celebrate "You can see which commit each branch points to!"
            echo ""
            echo -e "${WHITE}Now create and switch to a new branch in ONE command:${NC}"
            echo ""
            read -p "❯ " user_cmd
            retry_checkout_b
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git branch -v")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git branch -v"
    echo ""
    echo "Now try the shortcut command:"
    read -p "❯ " user_cmd
    retry_checkout_b
}

retry_checkout_b() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_git_checkout_b "$user_cmd"; then
            echo ""
            narrator_celebrate "Fancy! Created and switched in one command!"
            narrator_explain_advanced_branching
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git checkout -b")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git checkout -b feature"
    narrator_explain_advanced_branching
    echo ""
    read -p "Press Enter to continue..." dummy
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_branch_v() {
    cat << 'EOF'
  feature    abc1234 Add cool feature
* main       def5678 Initial commit
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_advanced_branching() {
    cat << 'EOF'
🗣️  "Advanced branching tricks:
    
    git checkout -b branch-name  = git branch + git checkout combined!
    git branch -m old new        = Rename a branch (useful!)
    git branch -a                = Show remote branches too (*)
    git branch -v                = Show last commit on each branch
    
    The * marks your current branch.
    Pro tip: git switch -c branch = new syntax for checkout -b!"
EOF
}