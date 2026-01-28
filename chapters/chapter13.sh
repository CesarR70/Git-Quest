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
# CHAPTER 13: Viewing Specific Commits
# Learning: git show
# ============================================================================

chapter13_intro() {
    clear_screen
    narrator_chapter_intro 13 "Viewing Specific Commits"
    
    cat << 'EOF'
🗣️  "You found a suspicious commit in your log. 'Fixed stuff' - 
    what does THAT even mean?! You need to see the actual changes.
    
    Enter git show - the magnifying glass of Git commands!
    
    git show displays:
    - The commit message
    - Who made the commit (author)
    - When it was committed
    - Exactly what files changed
    - The actual line-by-line diff
    
    It's like X-ray vision for your commits!
    
    Your task:
    Create a commit, then use git show to inspect it!"
EOF
    
    echo ""
    echo -e "${GREEN}$ echo 'Feature X implementation' > show.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git add show.txt${NC}"
    echo ""
    echo -e "${GREEN}$ git commit -m 'Implement amazing feature'${NC}"
    echo ""
    echo -e "${WHITE}Commit created: abc1234${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Now let's inspect that commit to see what exactly changed!
    You can use the short hash or just HEAD for the latest commit."
EOF
    
    echo ""
    read -p "❯ " user_cmd
    
    # Validate git show command
    if validate_git_show "$user_cmd"; then
        show_fake_git_show
        echo ""
        narrator_celebrate "There are the details! See everything that changed?"
        narrator_explain_show
        
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    else
        narrator_wrong_answer "$user_cmd" "git show HEAD"
        echo ""
        echo -e "${CYAN}Type 'hint' for help, or try again!${NC}"
        echo ""
        read -p "❯ " user_cmd
        
        # Retry loop
        local attempts=0
        while [[ $attempts -lt 3 ]]; do
            if validate_git_show "$user_cmd"; then
                show_fake_git_show
                echo ""
                narrator_celebrate "Good job! You got it."
                echo ""
                read -p "Press Enter to continue..." dummy
                return 0
            elif [[ "$user_cmd" == "hint" ]]; then
                echo -e "${GREEN}Hint: $(get_hint "git show")${NC}"
            else
                narrator_disappointed "Nope. Try again."
            fi
            ((attempts++))
            read -p "❯ " user_cmd
        done
        
        # Give up and show answer
        narrator_show_answer "git show HEAD"
        show_fake_git_show
        echo ""
        read -p "Press Enter to continue..." dummy
        return 0
    fi
}

# ============================================================================
# COMMAND SIMULATION (Fake git output)
# ============================================================================

show_fake_git_show() {
    cat << 'EOF'
commit abc1234 (HEAD -> main)
Author: You <you@example.com>
Date:   Mon Jan 27 10:00:00 2025 -0500

    Implement amazing feature

diff --git a/show.txt b/show.txt
new file mode 100644
index 0000000..1234567
--- /dev/null
+++ b/show.txt
@@ -0,0 +1 @@
+Feature X implementation
EOF
}

# ============================================================================
# NARRATOR EXPLANATIONS
# ============================================================================

narrator_explain_show() {
    cat << 'EOF'
🗣️  "git show reveals ALL the secrets:
    - Shows WHO made the change (Author line)
    - WHEN it was made (Date line)
    - WHAT exactly changed (the diff section)
    
    Those + lines are additions, - lines are deletions.
    You'll love this command when debugging!"
EOF
}