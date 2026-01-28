#!/bin/bash

# ============================================================================
# CHAPTER 9: Seeing the Changes
# Learning: git diff
# ============================================================================

chapter9_intro() {
    clear_screen
    narrator_chapter_intro 9 "Seeing the Changes"
    
    cat << 'EOF'
🗣️  "Alright, you're making changes to your code now. But how do you 
    actually SEE what's different? Reading every file line by line? 
    
    Oh honey, no. That's what git diff is for.
    
    git diff shows you:
    - Lines you ADDED (shown with a +)
    - Lines you DELETED (shown with a -)
    - Exactly what changed between commits
    
    It's like having X-ray vision for your code! Except... you know, 
    actually useful.
    
    Your task:
    Create a file, make some changes, then use git diff to see them!"
EOF
    
    echo ""
    echo -e "${GREEN}$ touch changes.txt${NC}"
    echo ""
    
    read -p "❯ " user_cmd
    
    # Validate command - check if user entered touch or similar file creation
    if validate_command "$user_cmd" "touch changes.txt"; then
        echo -e "${GREEN}changes.txt created!${NC}"
        echo ""
        show_git_diff_instructions
        return 0
    elif [[ "$user_cmd" == "touch"* ]] || [[ "$user_cmd" == *"changes.txt"* ]]; then
        # Near miss - slight variation
        echo -e "${GREEN}changes.txt created!${NC}"
        echo ""
        show_git_diff_instructions
        return 0
    else
        narrator_wrong_answer "$user_cmd" "touch changes.txt"
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop for file creation
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_command "$user_cmd" "touch changes.txt"; then
                echo -e "${GREEN}changes.txt created!${NC}"
                echo ""
                show_git_diff_instructions
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "touch changes.txt")${NC}"
            else
                narrator_disappointed "Nope. Try again."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        # Give up - show answer but continue
        echo -e "${GREEN}$ touch changes.txt${NC}"
        echo -e "${WHITE}changes.txt created!${NC}"
        echo ""
        show_git_diff_instructions
        return 0
    fi
}

# ============================================================================
# INSTRUCTIONS (Shown after file creation)
# ============================================================================

show_git_diff_instructions() {
    cat << 'EOF'
🗣️  "Great! Now let's add some content and make changes.
    
    First, write some initial content to the file."
EOF
    
    echo ""
    echo -e "${GREEN}$ echo 'Initial content' > changes.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add changes.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'Add changes.txt'${NC}"
    echo ""
    echo -e "${WHITE}Committed!${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Perfect! Now let's make some changes to see.
    
    Add a new line to the file."
EOF
    
    echo ""
    echo -e "${GREEN}$ echo 'A new line of code' >> changes.txt${NC}"
    echo ""
    echo -e "${WHITE}changes.txt updated!${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Now use git diff to see what changed between your working
    directory and the last commit!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git diff command
    if validate_command "$user_cmd" "git diff"; then
        show_fake_git_diff
        echo ""
        narrator_celebrate "Excellent! You can see exactly what changed."
        narrator_explain_diff
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        narrator_wrong_answer "$user_cmd" "git diff"
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_command "$user_cmd" "git diff"; then
                show_fake_git_diff
                echo ""
                narrator_celebrate "Good job! You figured it out."
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git diff")${NC}"
            else
                narrator_disappointed "Nope. Try again."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        # Give up and show answer
        narrator_show_answer "git diff"
        show_fake_git_diff
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_diff() {
    cat << 'EOF'
diff --git a/changes.txt b/changes.txt
index 1234567..89abcde 100644
--- a/changes.txt
+++ b/changes.txt
@@ -1 +1,2 @@
 Initial content
+A new line of code
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_diff() {
    cat << 'EOF'
🗣️  "Beautiful, isn't it? Look at that little + sign - that's your
    new line, freshly added and waiting to be committed.
    
    git diff is essential for:
    1. Code reviews - seeing exactly what changed
    2. Debugging - finding when something broke
    3. Self-review - checking your work before committing
    
    Pro tip: git diff --staged shows you what's STAGED but not yet committed!"
EOF
}