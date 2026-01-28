#!/bin/bash

# ============================================================================
# CHAPTER 11: Undoing Mistakes
# Learning: git reset
# ============================================================================

chapter11_intro() {
    clear_screen
    narrator_chapter_intro 11 "Undoing Mistakes"
    
    cat << 'EOF'
🗣️  "Oops. You just committed something you shouldn't have. Maybe a 
    debug log, maybe a password, maybe just a really bad joke in a 
    commit message.
    
    Don't panic! git reset is here to save your bacon.
    
    git reset can:
    - Undo the last commit (keeping changes)
    - Undo commits entirely (if you're feeling spicy)
    - Unstage files you accidentally added
    
    It's like Ctrl+Z for your Git history! (But be careful - 
    with great power comes great responsibility.)
    
    Your task:
    Make a commit, then reset it to see how it works!"
EOF
    
    echo ""
    echo -e "${GREEN}$ echo 'Oops I committed this' > undo.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add undo.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'Add oops commit'${NC}"
    echo ""
    echo -e "${WHITE}Committed!${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Ah, you committed something you didn't mean to. Let's undo it 
    with git reset~1, which means 'go back one commit'."
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git reset command
    if validate_git_reset "$user_cmd"; then
        show_fake_git_reset
        echo ""
        narrator_celebrate "Excellent! You successfully reset the commit!"
        narrator_explain_reset
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        narrator_wrong_answer "$user_cmd" "git reset~1"
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_reset "$user_cmd"; then
                show_fake_git_reset
                echo ""
                narrator_celebrate "Good job! You got it."
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git reset")${NC}"
            else
                narrator_disappointed "Nope. Try again."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        # Give up and show answer
        narrator_show_answer "git reset~1"
        show_fake_git_reset
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_reset() {
    cat << 'EOF'
Unstaged changes after reset:
  (use "git add <file>..." to update what will be committed)
	modified:   undo.txt
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_reset() {
    cat << 'EOF'
🗣️  "Beautiful reset! Your changes are back in your working directory, 
    ready to be fixed and recommitted properly.
    
    git reset comes in flavors:
    - git reset~1 (soft) - removes commit, keeps changes
    - git reset --hard~1 - DELETES changes (use with caution!)
    
    Pro tip: git reset HEAD <file> unstages a specific file!"
EOF
}