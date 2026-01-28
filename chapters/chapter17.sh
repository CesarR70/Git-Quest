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
# CHAPTER 17: Viewing Commit History
# Learning: git log --oneline, git log --graph, git log --all
# ============================================================================

chapter17_intro() {
    clear_screen
    narrator_chapter_intro 17 "Viewing Commit History"
    
    cat << 'EOF'
🗣️  "The repository is growing! Let's learn to read history
    like a pro with some magical git log flags.
    
    Essential log viewing:
    - git log --oneline        = Compact: hash + message only
    - git log --graph         = Visual ASCII branch diagram
    - git log --all           = Show ALL branches, not just current
    
    Combined for maximum clarity:
    git log --graph --oneline --all
    
    Your task:
    Let's explore the history!"
EOF
    
    echo ""
    echo -e "${WHITE}First, try the compact format:${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git log --oneline command
    if validate_command "$user_cmd" "git log --oneline"; then
        show_fake_git_log_oneline
        echo ""
        narrator_celebrate "Nice and compact! No fluff, just the essentials."
        echo ""
        echo -e "${WHITE}Now see the visual graph view:${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        if validate_command "$user_cmd" "git log --graph"; then
            show_fake_git_log_graph
            echo ""
            narrator_celebrate "You can literally SEE the branch structure!"
            narrator_explain_log_options
            
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        else
            # Retry graph
            narrator_wrong_answer "$user_cmd" "git log --graph"
            retry_log_graph
            return 0
        fi
    else
        # Initial command wrong
        narrator_wrong_answer "$user_cmd" "git log --oneline"
        retry_log_oneline
        return 0
    fi
}

# Retry functions
retry_log_oneline() {
    local attempts=0
    echo ""
    echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git log --oneline"; then
            show_fake_git_log_oneline
            echo ""
            narrator_celebrate "Compact and clean!"
            echo ""
            echo -e "${WHITE}Now try the graph view:${NC}"
            echo ""
            read -p "❯ " user_cmd
            retry_log_graph
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git log")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git log --oneline"
    echo ""
    echo "Now try graph view:"
    read -p "❯ " user_cmd
    retry_log_graph
}

retry_log_graph() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git log --graph"; then
            show_fake_git_log_graph
            echo ""
            narrator_celebrate "You can SEE the branches!"
            narrator_explain_log_options
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git log --graph")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git log --graph"
    show_fake_git_log_graph
    echo ""
    read -p "Press Enter to continue..." dummy
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_log_oneline() {
    cat << 'EOF'
abc1234 (HEAD -> main) Implement user authentication
def5678 Add database connection
ghi9012 Initial commit with project structure
EOF
}

show_fake_git_log_graph() {
    cat << 'EOF'
* abc1234 (HEAD -> main, feature/login) Implement user authentication
* def5678 (feature/login) Add database connection
| * 3456789 (feature/dashboard) Add dashboard UI
|/  
* ghi9012 Initial commit with project structure
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_log_options() {
    cat << 'EOF'
🗣️  "Git log flags to rule them all:
    
    --oneline      = One line per commit (hash + message)
    --graph        = ASCII art branch visualization
    --all          = Show commits from ALL branches
    --decorate     = Show branch/tag names
    -n 5           = Limit to last 5 commits
    
    Combine them for power:
    git log --graph --oneline --all --decorate
    
    Your future self will thank you for readable history!"
EOF
}