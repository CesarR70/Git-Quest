#!/bin/bash

# ============================================================================
# CHAPTER 7: Branching Out
# Learning: git branch
# ============================================================================

chapter7_intro() {
    clear_screen
    narrator_chapter_intro 7 "Branching Out"
    
    cat << 'EOF'
🗣️  "Alright, you're getting good at this! But here's where 
    things get really powerful: branching.
    
    Imagine you're writing a book. What if you wanted to try 
    a crazy plot twist without ruining the main story?
    
    You'd make a copy to experiment on, right? That's a branch!
    
    By default, you're on 'main' (or 'master'). But you can 
    create new branches for:
    • New features
    • Bug fixes
    • Experiments
    • Anything risky!
    
    git branch <name> creates a new branch
    git checkout <name> switches to it
    git branch        lists all branches
    
    Your task:
    Create a new branch called 'feature-login'!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate - use specific branch name validation
    if validate_git_branch_name "$user_cmd" "feature-login"; then
        show_fake_git_branch
        echo ""
        narrator_celebrate "Excellent! A new branch is born!"
        narrator_explain_branch
        
        echo ""
        read -p "Press Enter to switch to the new branch..." dummy
        show_fake_git_checkout "feature-login"
        echo ""
        narrator_celebrate "You're now on feature-login!"
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        # Check for near miss
        if [[ "$user_cmd" == "git branch" ]]; then
            echo -e "${YELLOW}You forgot to give the branch a name!${NC}"
        elif [[ "$user_cmd" == "git branch feature-login"* ]] || [[ "$user_cmd" == *"feature-login"* ]]; then
            # They're on the right track
            echo -e "${YELLOW}Almost! You need to type the command exactly right.${NC}"
        else
            narrator_wrong_answer "$user_cmd" "git branch <branch-name>"
        fi
        
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_branch_name "$user_cmd" "feature-login"; then
                show_fake_git_branch
                echo ""
                narrator_celebrate "You got it!"
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git branch")${NC}"
            else
                narrator_disappointed "Not quite."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        narrator_show_answer "git branch feature-login"
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}
