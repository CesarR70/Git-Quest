#!/bin/bash

# ============================================================================
# CHAPTER 10: Stashing Changes
# Learning: git stash
# ============================================================================

chapter10_intro() {
    clear_screen
    narrator_chapter_intro 10 "Stashing Changes"
    
    cat << 'EOF'
🗣️  "Oh no! You're halfway through changing your login page when 
    suddenly - DISASTER! A critical bug needs fixing NOW.
    
    But you're not ready to commit your half-done login page work...
    
    Enter git stash - your safety net for code-in-progress!
    
    git stash:
    - Temporarily saves your uncommitted changes
    - Gives you a clean working directory
    - Lets you switch context without committing garbage
    
    It's like putting your work in a pocket for later. A magical, 
    digital pocket.
    
    Your task:
    Make some changes, then stash them to see how it works!"
EOF
    
    echo ""
    echo -e "${GREEN}$ echo 'Half-done login feature' > stash.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add stash.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'Start login feature'${NC}"
    echo ""
    echo -e "${WHITE}Committed!${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Great! Now let's make some changes you'd want to save for later."
EOF
    
    echo ""
    echo -e "${GREEN}$ echo 'Still working on it...' >> stash.txt${NC}"
    echo ""
    echo -e "${WHITE}stash.txt updated!${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Now you need to fix an urgent bug, but this file isn't ready 
    to be committed. What do you do?"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git stash command
    if validate_git_stash "$user_cmd"; then
        show_fake_git_stash
        echo ""
        narrator_celebrate "Perfect! Your changes are safely stashed!"
        narrator_explain_stash
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        narrator_wrong_answer "$user_cmd" "git stash"
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_stash "$user_cmd"; then
                show_fake_git_stash
                echo ""
                narrator_celebrate "Good job! You got it."
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git stash")${NC}"
            else
                narrator_disappointed "Nope. Try again."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        # Give up and show answer
        narrator_show_answer "git stash"
        show_fake_git_stash
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_stash() {
    cat << 'EOF'
Saved working directory and index state WIP on main: abc1234 Start login feature
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_stash() {
    cat << 'EOF'
🗣️  "LOOK AT THAT! Your changes are safely tucked away, and your 
    working directory is clean. You can now fix that bug without 
    worrying about your half-done work.
    
    git stash is perfect for:
    1. Context switching - jump between tasks seamlessly
    2. Pulling updates - get latest changes without committing
    3. Saving work-in-progress - without polluting commit history
    
    Pro tip: git stash pop brings your stashed changes back!"
EOF
}