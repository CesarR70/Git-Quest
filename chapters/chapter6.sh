#!/bin/bash

# ============================================================================
# CHAPTER 6: Sharing Your Work
# Learning: git push
# ============================================================================

chapter6_intro() {
    clear_screen
    narrator_chapter_intro 6 "Sharing Your Work"
    
    cat << 'EOF'
🗣️  "You've been working locally, but what if you want to share 
    your code with the world (or your team)?
    
    That's where git push comes in! It sends your local commits 
    to a remote repository (like GitHub, GitLab, or Bitbucket).
    
    Before pushing, you need to add a remote. Think of it as 
    bookmarking a URL where your code will live online.
    
    The workflow:
    1. git remote add origin <url>  (one-time setup)
    2. git push origin main      (first push, sets up tracking)
    
    Your task:
    Add the remote and push your code!"
EOF
    
    # Track which step we're on: 1=add remote, 2=push
    local step=1
    
    while true; do
        echo ""
        if [[ "$step" == "1" ]]; then
            read -p "❯ " user_cmd
            
            # Check for hint command
            if [[ "$user_cmd" == "hint" ]]; then
                echo -e "${YELLOW}Use: git remote add origin <url>${NC}"
                echo "  For example: git remote add origin https://github.com/user/repo.git"
                continue
            fi
            
            # Check if they tried push without remote
            if [[ "$user_cmd" == *"push"* ]]; then
                echo -e "${YELLOW}You need to add a remote first!${NC}"
                continue
            fi
            
            # Validate remote add
            if validate_git_remote "$user_cmd"; then
                show_fake_git_remote
                step=2
            else
                echo -e "${YELLOW}Invalid command. Use: git remote add origin <url>${NC}"
            fi
        else
            read -p "❯ " user_cmd2
            
            # Check for hint command
            if [[ "$user_cmd2" == "hint" ]]; then
                echo -e "${YELLOW}Use: git push origin main${NC}"
                continue
            fi
            
            # Validate push
            if validate_git_push "$user_cmd2"; then
                show_fake_git_push
                echo ""
                narrator_celebrate "Success! Your code is now on the remote!"
                narrator_explain_push
                
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            else
                echo -e "${YELLOW}Invalid command. Use: git push origin main${NC}"
            fi
        fi
    done
}
