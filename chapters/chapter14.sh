#!/bin/bash

# ============================================================================
# DEPENDENCIES
# ============================================================================

# Source library modules for access to validation functions
CHAPTER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${CHAPTER_DIR}/../lib/colors.sh"
source "${CHAPTER_DIR}/../lib/ui.sh"
source "${CHAPTER_DIR}/../lib/narrator.sh"
source "${CHAPTER_DIR}/../lib/validator.sh"

# ============================================================================
# CHAPTER 14: Working with Branches
# Learning: git branch, git checkout, git merge workflow
# ============================================================================

chapter14_intro() {
    clear_screen
    narrator_chapter_intro 14 "Working with Branches"
    
    cat << 'EOF'
🗣️  "Time to get your hands dirty with branches! You've been 
    living on main/master and it's getting crowded.
    
    Branches let you:
    - Work on features without breaking the main code
    - Experiment freely (delete if it goes wrong!)
    - Collaborate with others on different features
    
    The workflow is simple:
    1. Create a branch (git branch feature-name)
    2. Switch to it (git checkout feature-name)
    3. Do work, commit changes
    4. Switch back (git checkout main)
    5. Merge your work (git merge feature-name)
    
    Your task:
    Create a branch, make a commit, switch back, and merge!"
EOF
    
    echo ""
    echo -e "${GREEN}$ git branch feature${NC}"
    echo ""
    echo -e "${GREEN}$ git checkout feature${NC}"
    echo ""
    echo -e "${GREEN}$ echo 'Feature work' > feature.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add feature.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'Add feature'${NC}"
    echo ""
    echo -e "${GREEN}$ git checkout main${NC}"
    echo ""
    echo -e "${GREEN}$ git merge feature${NC}"
    echo ""
    echo -e "${WHITE}Let's practice! First, create a branch called 'feature':${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git branch command
    if validate_command "$user_cmd" "git branch feature"; then
        echo ""
        narrator_celebrate "Branch created! Now switch to it."
        echo ""
        read -p "❯ " user_cmd
        
        if validate_command "$user_cmd" "git checkout feature"; then
            echo ""
            narrator_celebrate "You're on the feature branch! Now let's do some work."
            echo ""
            echo -e "${WHITE}Step 1: Create a file with some content:${NC}"
            echo ""
            echo -e "${GREEN}$ echo 'Feature work' > feature.txt${NC}"
            echo ""
            read -p "❯ " user_cmd
            
            # Accept echo command with any variation
            if [[ "$user_cmd" =~ echo.*feature\.txt ]]; then
                echo ""
                narrator_celebrate "File created! Now add it to the staging area."
                echo ""
                echo -e "${WHITE}Step 2: Stage the file:${NC}"
                echo ""
                echo -e "${GREEN}$ git add feature.txt${NC}"
                echo ""
                read -p "❯ " user_cmd
                
                if validate_command "$user_cmd" "git add feature.txt"; then
                    echo ""
                    narrator_celebrate "File staged! Now commit your changes."
                    echo ""
                    echo -e "${WHITE}Step 3: Commit the changes:${NC}"
                    echo ""
                    echo -e "${GREEN}$ git commit -m 'Add feature'${NC}"
                    echo ""
                    read -p "❯ " user_cmd
                    
                    if validate_git_commit "$user_cmd"; then
                        echo ""
                        narrator_celebrate "Commit made! Now switch back to main."
                        echo ""
                        read -p "❯ " user_cmd
                        
                        if validate_command "$user_cmd" "git checkout main"; then
                            echo ""
                            narrator_celebrate "You're back on main! Now merge the feature."
                            echo ""
                            read -p "❯ " user_cmd
                            
                            if validate_command "$user_cmd" "git merge feature"; then
                                show_fake_git_merge
                                echo ""
                                narrator_celebrate "Merge successful! You've mastered branch workflow!"
                                narrator_explain_branch_workflow
                                echo ""
                                read -p "Press Enter to continue..." dummy
                                return 0
                            else
                                # Retry merge
                                narrator_wrong_answer "$user_cmd" "git merge feature"
                                retry_merge
                                return 0
                            fi
                        else
                            # Retry checkout main
                            narrator_wrong_answer "$user_cmd" "git checkout main"
                            retry_checkout_main
                            return 0
                        fi
                    else
                        # Retry commit
                        narrator_wrong_answer "$user_cmd" "git commit -m 'Add feature'"
                        retry_commit
                        return 0
                    fi
                else
                    # Retry add
                    narrator_wrong_answer "$user_cmd" "git add feature.txt"
                    retry_add
                    return 0
                fi
            else
                # Retry echo command
                narrator_wrong_answer "$user_cmd" "echo 'Feature work' > feature.txt"
                retry_echo
                return 0
            fi
        else
            # Retry checkout
            narrator_wrong_answer "$user_cmd" "git checkout feature"
            retry_checkout
            return 0
        fi
    else
        # Initial command wrong
        narrator_wrong_answer "$user_cmd" "git branch feature"
        retry_branch
        return 0
    fi
}

# ============================================================================
# RETRY FUNCTIONS
# ============================================================================

retry_branch() {
    local attempts=0
    echo ""
    echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
    echo ""
    read -p "❯ " user_cmd
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git branch feature"; then
            echo ""
            narrator_celebrate "Branch created! Now switch to it."
            echo ""
            read -p "❯ " user_cmd
            retry_checkout
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git branch")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git branch feature"
    echo ""
    echo "Now switch to it:"
    read -p "❯ " user_cmd
    retry_checkout
}

retry_checkout() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git checkout feature"; then
            echo ""
            narrator_celebrate "You're on the feature branch! Now let's do some work."
            echo ""
            echo -e "${WHITE}Step 1: Create a file with some content:${NC}"
            echo ""
            echo -e "${GREEN}$ echo 'Feature work' > feature.txt${NC}"
            echo ""
            read -p "❯ " user_cmd
            
            if [[ "$user_cmd" =~ echo.*feature\.txt ]]; then
                echo ""
                narrator_celebrate "File created! Now add it to the staging area."
                echo ""
                echo -e "${WHITE}Step 2: Stage the file:${NC}"
                echo ""
                echo -e "${GREEN}$ git add feature.txt${NC}"
                echo ""
                read -p "❯ " user_cmd
                
                if validate_command "$user_cmd" "git add feature.txt"; then
                    echo ""
                    narrator_celebrate "File staged! Now commit your changes."
                    echo ""
                    echo -e "${WHITE}Step 3: Commit the changes:${NC}"
                    echo ""
                    echo -e "${GREEN}$ git commit -m 'Add feature'${NC}"
                    echo ""
                    read -p "❯ " user_cmd
                    retry_commit_main
                    return 0
                else
                    narrator_wrong_answer "$user_cmd" "git add feature.txt"
                    retry_add
                    return 0
                fi
            else
                narrator_wrong_answer "$user_cmd" "echo 'Feature work' > feature.txt"
                retry_echo
                return 0
            fi
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git checkout")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git checkout feature"
}

retry_echo() {
    local attempts=0
    
    while [[ $attempts -lt 2 ]]; do
        echo ""
        echo -e "${CYAN}Hint: Type exactly: echo 'Feature work' > feature.txt${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        if [[ "$user_cmd" =~ echo.*feature\.txt ]]; then
            echo ""
            narrator_celebrate "File created! Now add it to the staging area."
            echo ""
            echo -e "${GREEN}$ git add feature.txt${NC}"
            echo ""
            read -p "❯ " user_cmd
            retry_add
            return 0
        fi
        ((attempts++))
    done
    
    echo ""
    echo "Okay, I'll just create the file for you..."
    echo ""
    narrator_show_answer "echo 'Feature work' > feature.txt"
    echo ""
    echo "Now add the file:"
    read -p "❯ " user_cmd
    retry_add
}

retry_add() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git add feature.txt"; then
            echo ""
            narrator_celebrate "File staged! Now commit your changes."
            echo ""
            echo -e "${GREEN}$ git commit -m 'Add feature'${NC}"
            echo ""
            read -p "❯ " user_cmd
            retry_commit_main
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git add")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git add feature.txt"
    echo ""
    echo "Now commit the changes:"
    read -p "❯ " user_cmd
    retry_commit_main
}

retry_commit() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_git_commit "$user_cmd"; then
            echo ""
            narrator_celebrate "Commit made! Now switch back to main."
            echo ""
            read -p "❯ " user_cmd
            retry_checkout_main
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git commit")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git commit -m 'Add feature'"
    echo ""
    echo "Now switch back to main:"
    read -p "❯ " user_cmd
    retry_checkout_main
}

retry_commit_main() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_git_commit "$user_cmd"; then
            echo ""
            narrator_celebrate "Commit made! Now switch back to main."
            echo ""
            read -p "❯ " user_cmd
            retry_checkout_main
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git commit")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git commit -m 'Add feature'"
    echo ""
    echo "Now switch back to main:"
    read -p "❯ " user_cmd
    retry_checkout_main
}

retry_checkout_main() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git checkout main"; then
            echo ""
            narrator_celebrate "You're back on main! Now merge the feature."
            echo ""
            read -p "❯ " user_cmd
            retry_merge
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git checkout")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git checkout main"
    echo ""
    echo "Now merge the feature:"
    read -p "❯ " user_cmd
    retry_merge
}

retry_merge() {
    local attempts=0
    
    while [[ $attempts -lt 3 ]]; do
        if validate_command "$user_cmd" "git merge feature"; then
            show_fake_git_merge
            echo ""
            narrator_celebrate "Merge successful! You've mastered branch workflow!"
            narrator_explain_branch_workflow
            echo ""
            read -p "Press Enter to continue..." dummy
            return 0
        elif [[ "$user_cmd" == "hint" ]]; then
            echo -e "${GREEN}Hint: $(get_hint "git merge")${NC}"
        else
            narrator_disappointed "Nope. Try again."
        fi
        ((attempts++))
        read -p "❯ " user_cmd
    done
    
    narrator_show_answer "git merge feature"
    show_fake_git_merge
    echo ""
    read -p "Press Enter to continue..." dummy
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_merge() {
    cat << 'EOF'
Updating abc1234..def5678
Fast-forward
 feature.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 feature.txt
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_branch_workflow() {
    cat << 'EOF'
🗣️  "You just completed the branch workflow! Here's the pattern:
    
    1. git branch feature-name  - Create the branch
    2. git checkout feature     - Switch to it (or git switch)
    3. Do your work, commit     - Work in isolation
    4. git checkout main        - Go back to main
    5. git merge feature        - Bring in your changes
    
    Pro tips:
    - git checkout -b feature  = create AND switch in one command!
    - git branch -d feature    = delete a branch (safe delete)
    - git branch -D feature    = force delete (unmerged work lost!)"
EOF
}