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
# CHAPTER 16: Rewriting History
# Learning: git commit --amend, git rebase
# ============================================================================

chapter16_intro() {
    clear_screen
    narrator_chapter_intro 16 "Rewriting History"
    
    cat << 'EOF'
🗣️  "Oops! You committed with 'Fixed stuff' again. 
    The git gods weep when they see such commit messages.
    
    Fortunately, you can FIX your last commit with:
    git commit --amend -m "A proper message"
    
    It replaces the last commit entirely - same files, new message!
    Think of it as an 'edit last commit' super power.
    
    Your task:
    Make a commit with a bad message, then amend it!"
EOF
    
    echo ""
    echo -e "${GREEN}$ git commit --allow-empty -m 'Fixed stuff'${NC}"
    echo ""
    echo -e "${WHITE}First, make a commit with that terrible message:${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    # Validate initial commit command
    if validate_command "$user_cmd" "git commit --allow-empty -m '*Fixed stuff*'"; then
        echo ""
        show_fake_bad_commit
        echo ""
        narrator_disappointed "Oh no! 'Fixed stuff'?! The commit history weeps."
        echo ""
        echo -e "${WHITE}Now let's amend that mess to something proper:${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        if validate_git_commit "$user_cmd"; then
            show_fake_amend_commit
            echo ""
            narrator_celebrate "History corrected! Much better!"
            narrator_explain_amend
            
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        else
            # Retry amend
            narrator_wrong_answer "$user_cmd" "git commit --amend -m 'Proper message'"
            retry_amend
            return 0
        fi
    else
        # Initial command wrong
        narrator_wrong_answer "$user_cmd" "git commit --allow-empty -m 'Fixed stuff'"
        retry_initial_commit
        return 0
    fi
}

# Retry functions
retry_initial_commit() {
    local attempts=0
    echo ""
    echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git commit --allow-empty -m '*Fixed stuff*'"; then
            show_fake_bad_commit
            echo ""
            narrator_disappointed "Oh no! 'Fixed stuff'?! The commit history weeps."
            echo ""
            echo -e "${WHITE}Now let's amend that mess:${NC}"
            echo ""
            read -p "❯ " user_cmd
            retry_amend
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git commit")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git commit --allow-empty -m 'Fixed stuff'"
    echo ""
    echo "Now amend it:"
    read -p "❯ " user_cmd
    retry_amend
}

retry_amend() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_git_commit "$user_cmd"; then
            show_fake_amend_commit
            echo ""
            narrator_celebrate "History corrected!"
            narrator_explain_amend
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: Use git commit --amend -m 'your message'${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git commit --amend -m 'Proper commit message'"
    show_fake_amend_commit
    echo ""
    read -p "Press Enter to continue..." dummy
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_bad_commit() {
    cat << 'EOF'
[main abc1234] Fixed stuff
 1 file changed, 1 insertion(+)
EOF
}

show_fake_amend_commit() {
    cat << 'EOF'
[main def5678] Properly document the feature implementation
 1 file changed, 1 insertion(+)
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_amend() {
    cat << 'EOF'
ANOTHER GIT POWER-UP! 🗡️
    
    git commit --amend replaces the LAST commit entirely.
    The files stay, but you get a NEW commit with new message.
    
    WARNING: Never amend commits you've shared/pushed!
    It changes history and breaks things for others.
    
    Use cases:
    - Typos in commit message
    - Forgot to stage a file (amend adds it!)
    - Just need a quick fix before pushing"
EOF
}