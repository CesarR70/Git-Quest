#!/bin/bash

# ============================================================================
# CHAPTER 2: Staging Changes
# Learning: git add
# ============================================================================

chapter2_intro() {
    clear_screen
    narrator_chapter_intro 2 "Staging Changes"
    
    cat << 'EOF'
🗣️  "Alright, you've initialized the repository. But just having 
    an empty repository isn't very useful, is it?
    
    Let me introduce you to the staging area - Git's way of 
    saying 'I'm about to save this, but not quite yet.'
    
    First, let's create a file. Don't worry, I'll do it for you..."
EOF
    
    echo ""
    echo -e "${GREEN}$ touch index.html${NC}"
    echo ""
    echo -e "${WHITE}Created index.html${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Now, index.html exists but Git isn't tracking it. We need to 
    tell Git 'hey, pay attention to this file!'
    
    That's where git add comes in. You add files to the staging 
    area, then commit them together.
    
    Your task:
    Add index.html to the staging area!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate
    if validate_git_add "$user_cmd"; then
        show_fake_git_add
        echo ""
        narrator_celebrate "Excellent! The file is staged and ready."
        narrator_explain_add
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        # Check for near miss
        if [[ "$user_cmd" == "git add" ]]; then
            echo -e "${YELLOW}You forgot to specify which file!${NC}"
        else
            narrator_wrong_answer "$user_cmd" "git add <file>"
        fi
        
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_add "$user_cmd"; then
                show_fake_git_add
                echo ""
                narrator_celebrate "There we go!"
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git add")${NC}"
            else
                narrator_disappointed "Still not right."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        narrator_show_answer "git add index.html"
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}
