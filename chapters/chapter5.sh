#!/bin/bash

# ============================================================================
# CHAPTER 5: Looking Back
# Learning: git log
# ============================================================================

chapter5_intro() {
    clear_screen
    narrator_chapter_intro 5 "Looking Back"
    
    cat << 'EOF'
🗣️  "Time travel isn't real, but with Git you can at least 
    see your project's history!
    
    git log shows you every commit you've ever made, in order 
    from newest to oldest. It's like a journal of your project's 
    life.
    
    Each commit shows:
    • The commit hash (unique ID)
    • The author
    • The date
    • Your commit message
    
    Pro tip: Press 'q' to quit if the log is long!
    
    Your task:
    View your commit history!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate
    if validate_git_log "$user_cmd"; then
        show_fake_git_log
        echo ""
        narrator_celebrate "Beautiful history! Every commit tells a story."
        narrator_explain_log
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        narrator_wrong_answer "$user_cmd" "git log"
        
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_log "$user_cmd"; then
                show_fake_git_log
                echo ""
                narrator_celebrate "There it is!"
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git log")${NC}"
            else
                narrator_disappointed "Nope."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        narrator_show_answer "git log"
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}
