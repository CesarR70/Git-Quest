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
# CHAPTER 12: Finding Specific Commits
# Learning: git log --oneline
# ============================================================================

chapter12_intro() {
    clear_screen
    narrator_chapter_intro 12 "Finding Specific Commits"
    
    cat << 'EOF'
🗣️  "Your git log is getting crowded. What started as a simple 
    project now has 47 commits, and you're looking for that one 
    commit where you broke everything.
    
    git log --oneline is your new best friend!
    
    It shows:
    - Each commit on one line
    - Short commit hash (first 7 characters)
    - Commit message
    
    Much cleaner than the full git log! It's like a TL;DR for 
    your commit history.
    
    Your task:
    Create a few commits, then use git log --oneline to see them!"
EOF
    
    echo ""
    echo -e "${GREEN}$ echo 'First change' > logtest.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add logtest.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'First commit'${NC}"
    echo ""
    echo -e "${GREEN}$ echo 'Second change' >> logtest.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add logtest.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'Second commit'${NC}"
    echo ""
    echo -e "${GREEN}$ echo 'Third change' >> logtest.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add logtest.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'Third commit'${NC}"
    echo ""
    echo -e "${WHITE}Three commits created!${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Now let's see your commit history in a cleaner format!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git log --oneline command
    if validate_command "$user_cmd" "git log --oneline"; then
        show_fake_git_log_oneline
        echo ""
        narrator_celebrate "Perfect! Much cleaner, right?"
        narrator_explain_log_oneline
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    elif [[ "$user_cmd" == *"log"* ]]; then
        # Near miss - has log but missing --oneline
        echo -e "${YELLOW}Try adding --oneline for a cleaner view!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        if validate_command "$user_cmd" "git log --oneline"; then
            show_fake_git_log_oneline
            echo ""
            narrator_celebrate "There it is! Beautiful, isn't it?"
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        fi
    else
        narrator_wrong_answer "$user_cmd" "git log --oneline"
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_command "$user_cmd" "git log --oneline"; then
                show_fake_git_log_oneline
                echo ""
                narrator_celebrate "Good job! You got it."
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git log --oneline")${NC}"
            else
                narrator_disappointed "Nope. Try again."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        # Give up and show answer
        narrator_show_answer "git log --oneline"
        show_fake_git_log_oneline
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_log_oneline() {
    cat << 'EOF'
abc1234 (HEAD -> main) Third commit
def5678 Second commit
9abcdef First commit
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_log_oneline() {
    cat << 'EOF'
🗣️  "SEE? Much better! You can instantly see all your commits 
    without the wall of text.
    
    Those first 7 characters? That's the short commit hash.
    You can use it with git show <hash> to see details!
    
    Pro tips:
    - git log -n 3 shows only 3 commits
    - git log --oneline --graph shows branches visually!"
EOF
}