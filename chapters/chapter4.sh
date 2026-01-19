#!/bin/bash

# ============================================================================
# CHAPTER 4: Checking Your Work
# Learning: git status
# ============================================================================

chapter4_intro() {
    clear_screen
    narrator_chapter_intro 4 "Checking Your Work"
    
    cat << 'EOF'
🗣️  "Okay, you've made some commits. But how do you know where 
    you stand? What files have changed? What's ready to commit?
    
    Enter git status - your best friend in Git.
    
    It tells you:
    • Which files have been modified
    • Which files are staged (ready to commit)
    • Which files aren't tracked at all
    
    Red text = not staged
    Green text = staged and ready
    
    Your task:
    Check the current status of your repository!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate
    if validate_git_status "$user_cmd"; then
        show_fake_git_status
        echo ""
        narrator_celebrate "Clean! Everything is committed."
        narrator_explain_status
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        narrator_wrong_answer "$user_cmd" "git status"
        
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_status "$user_cmd"; then
                show_fake_git_status
                echo ""
                narrator_celebrate "That's it!"
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git status")${NC}"
            else
                narrator_disappointed "Nope."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        narrator_show_answer "git status"
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}
