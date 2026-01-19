#!/bin/bash

# ============================================================================
# CHAPTER 8: Bringing It Together
# Learning: git checkout & git merge
# ============================================================================

chapter8_intro() {
    clear_screen
    narrator_chapter_intro 8 "Bringing It Together"
    
    cat << 'EOF'
🗣️  "Okay, you've created a branch and made some changes. 
    But how do you get those changes back into the main branch?
    
    Enter git merge! It's how you combine the history of two 
    branches into one.
    
    First, you need to switch back to the main branch with 
    git checkout. Then merge your feature branch into it.
    
    The workflow:
    1. git checkout main      → Go back to main
    2. git merge feature-xxx  → Bring in the changes
    
    ⚠️  Warning: If both branches changed the same file, 
        you'll get a merge conflict! But that's a story 
        for another day...
    
    Your task:
    Switch back to main and merge the feature-login branch!"
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate checkout to main
    if validate_git_checkout "$user_cmd"; then
        show_fake_git_checkout "main"
        echo ""
        
        cat << 'EOF'
🗣️  "Perfect! Now you're back on main. Let's merge in that 
    feature-login branch!"
EOF
        
        echo ""
        read -p "❯ " user_cmd2
        
        if validate_git_merge "$user_cmd2"; then
            show_fake_git_merge
            echo ""
            narrator_celebrate "AMAZING! The feature-login branch has been merged into main!"
            narrator_explain_merge
            
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        else
            narrator_wrong_answer "$user_cmd2" "git merge feature-login"
            echo ""
            read -p "❯ " user_cmd2
            
            if validate_git_merge "$user_cmd2"; then
                show_fake_git_merge
                echo ""
                narrator_celebrate "You're now a Git master!"
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            fi
        fi
    else
        narrator_wrong_answer "$user_cmd" "git checkout main"
        
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        if validate_git_checkout "$user_cmd"; then
            show_fake_git_checkout "main"
            echo ""
            read -p "❯ " user_cmd2
            
            if validate_git_merge "$user_cmd2"; then
                show_fake_git_merge
                echo ""
                narrator_celebrate "You did it!"
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            fi
        fi
    fi
    
    # Show answer
    echo ""
    show_fake_git_checkout "main"
    show_fake_git_merge
    echo ""
    narrator_celebrate "You're now a Git master!"
    echo ""
    read -p "Press Enter to continue..." dummy
    return 0
}
