#!/bin/bash

# ============================================================================
# CHAPTER 3: Making It Permanent
# Learning: git commit
# ============================================================================

chapter3_intro() {
    clear_screen
    narrator_chapter_intro 3 "Making It Permanent"
    
    cat << 'EOF'
🗣️  "Great! Your file is staged. But wait... it's not saved yet.
    
    In Git, there are two steps to saving:
    1. git add  → Stage changes
    2. git commit → Actually save them
    
    A commit is like taking a snapshot of your project. It's 
    saved in the history forever (or until someone force pushes 
    over it... don't do that).
    
    The -m flag is CRUCIAL. It lets you add a commit message. 
    ALWAYS write meaningful messages!
    
    Good: "Add user login functionality"
    Bad:  "stuff" or "update"
    
    Your task:
    Commit your changes with a meaningful message!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate
    if validate_git_commit "$user_cmd"; then
        show_fake_git_commit "Initial commit with index.html"
        echo ""
        narrator_celebrate "Perfect! Your changes are now saved in history."
        narrator_explain_commit
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        # Check for near miss
        if [[ "$user_cmd" == "git commit" ]]; then
            echo -e "${YELLOW}You forgot the -m flag! Git needs a message.${NC}"
        else
            narrator_wrong_answer "$user_cmd" "git commit -m 'message'"
        fi
        
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_commit "$user_cmd"; then
                show_fake_git_commit "Initial commit with index.html"
                echo ""
                narrator_celebrate "There it is!"
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git commit")${NC}"
            else
                narrator_disappointed "Nope. Think about what you're missing."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        narrator_show_answer "git commit -m 'Add initial index.html file'"
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}
