#!/bin/bash

# ============================================================================
# CHAPTER 1: The Beginning
# Learning: git init
# ============================================================================

chapter1_intro() {
    clear_screen
    narrator_chapter_intro 1 "The Beginning"
    
    cat << 'EOF'
🗣️  "Alright, fresh meat- I mean, new developer. Let's begin.
    
    You want to work with Git, but first you need to... wait for it...
    initialize it!
    
    Think of it like buying a new notebook. You can't start writing 
    until you actually open it up and decide to use it.
    
    The command is simple: git init
    
    This creates a hidden '.git' folder in your project. That's where 
    Git stores all the magic - the history, the branches, everything.
    
    Your task:
    Initialize a new Git repository!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate
    if validate_git_init "$user_cmd"; then
        show_fake_git_init
        echo ""
        narrator_celebrate "Good job! The repository is initialized."
        narrator_explain_init
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        # Check for near miss
        local hint=$(analyze_near_miss "$user_cmd" "git init")
        if [[ -n "$hint" ]]; then
            echo -e "${YELLOW}$hint${NC}"
        else
            narrator_wrong_answer "$user_cmd" "git init"
        fi
        
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_init "$user_cmd"; then
                show_fake_git_init
                echo ""
                narrator_celebrate "Finally! You got it."
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git init")${NC}"
            else
                narrator_disappointed "Nope. Try again."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        # Give up and show answer
        narrator_show_answer "git init"
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}
