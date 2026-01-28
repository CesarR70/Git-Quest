#!/bin/bash

# ============================================================================
#                    GIT QUEST - The Git Learning Game
# ============================================================================
# 
# A terminal-based game to learn Git commands interactively.
# Run this script from the git-quest directory.
#
# Usage: ./git-quest.sh
#
# ============================================================================

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all library files
source "${SCRIPT_DIR}/lib/colors.sh"
source "${SCRIPT_DIR}/lib/ui.sh"
source "${SCRIPT_DIR}/lib/narrator.sh"
source "${SCRIPT_DIR}/lib/validator.sh"

# Source all chapters
source "${SCRIPT_DIR}/chapters/chapter1.sh"
source "${SCRIPT_DIR}/chapters/chapter2.sh"
source "${SCRIPT_DIR}/chapters/chapter3.sh"
source "${SCRIPT_DIR}/chapters/chapter4.sh"
source "${SCRIPT_DIR}/chapters/chapter5.sh"
source "${SCRIPT_DIR}/chapters/chapter6.sh"
source "${SCRIPT_DIR}/chapters/chapter7.sh"
source "${SCRIPT_DIR}/chapters/chapter8.sh"
source "${SCRIPT_DIR}/chapters/chapter9.sh"
source "${SCRIPT_DIR}/chapters/chapter10.sh"
source "${SCRIPT_DIR}/chapters/chapter11.sh"
source "${SCRIPT_DIR}/chapters/chapter12.sh"
source "${SCRIPT_DIR}/chapters/chapter13.sh"
source "${SCRIPT_DIR}/chapters/chapter14.sh"
source "${SCRIPT_DIR}/chapters/chapter15.sh"
source "${SCRIPT_DIR}/chapters/chapter16.sh"
source "${SCRIPT_DIR}/chapters/chapter17.sh"

# ============================================================================
# MAIN GAME
# ============================================================================

show_title_screen() {
    clear_screen
    
echo ""
echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║                                                                               ║${NC}"
echo -e "${MAGENTA}║  ${WHITE}  ░░░░░░  ░░ ░░░░░░░░      ░░░░░░  ░░    ░░ ░░░░░░░ ░░░░░░░ ░░░░░░░░  ${MAGENTA}  ║${NC}"
echo -e "${MAGENTA}║  ${WHITE} ▒▒       ▒▒    ▒▒        ▒▒    ▒▒ ▒▒    ▒▒ ▒▒      ▒▒         ▒▒     ${MAGENTA}  ║${NC}"
echo -e "${MAGENTA}║  ${WHITE} ▒▒   ▒▒▒ ▒▒    ▒▒        ▒▒    ▒▒ ▒▒    ▒▒ ▒▒▒▒▒   ▒▒▒▒▒▒▒    ▒▒     ${MAGENTA}  ║${NC}"
echo -e "${MAGENTA}║  ${WHITE} ▓▓    ▓▓ ▓▓    ▓▓        ▓▓ ▄▄ ▓▓ ▓▓    ▓▓ ▓▓           ▓▓    ▓▓     ${MAGENTA}  ║${NC}"
echo -e "${MAGENTA}║  ${WHITE}  ██████  ██    ██         ██████   ██████  ███████ ███████    ██     ${MAGENTA}  ║${NC}"
echo -e "${MAGENTA}║                                                                               ║${NC}"
echo -e "${MAGENTA}║                      ${WHITE}━━━  T H E   G A M E  ━━━${MAGENTA}                             ║${NC}"
echo -e "${MAGENTA}║                                                                               ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}              A terminal-based adventure to master Git!${NC}"
echo ""
    
    cat << 'EOF'
         ┌─────────────────────────────────────────────────────┐
         │                                                     │
         │   Learn Git through hands-on practice:              │
         │   • git init     - Initialize a repository          │
         │   • git add      - Stage changes                    │
         │   • git commit   - Save your work                   │
         │   • git status   - Check your changes               │
         │   • git log      - View history                     │
         │   • git push     - Share with the world             │
         │   • git branch   - Create parallel worlds           │
         │   • git merge    - Bring branches together          │
         │                                                     │
         │   Type commands to complete each challenge!         │
         │                                                     │
         └─────────────────────────────────────────────────────┘
EOF
    
    echo ""
    echo -e "${GREEN}                    Press Enter to begin...${NC}"
    echo ""
    read -p "" dummy
}

show_completion_screen() {
    clear_screen
    
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                                ║${NC}"
    echo -e "${GREEN}║     ${WHITE}   ★  ★  ★  C O N G R A T U L A T I O N S  ★  ★  ★     ${GREEN}║${NC}"
    echo -e "${GREEN}║                                                                ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    cat << 'EOF'
🗣️  "Incredible! You've completed Git Quest!
    
    You now know the fundamental Git commands:
    
    ✓ Initialize repositories
    ✓ Stage and commit changes
    ✓ Check status and view history
    ✓ Push to remote servers
    ✓ Create and merge branches
    
    You're ready to start using Git for real!
    
    Remember:
    • Commit often with meaningful messages
    • Use branches for new features
    • Always pull before you push
    
    Now go forth and version control!"
EOF
    
    echo ""
    echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${CYAN}           Thank you for playing Git Quest!${NC}"
    echo ""
    echo -e "${MAGENTA}              Keep coding, keep learning! 🚀${NC}"
    echo ""
    echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
    echo ""
}

show_menu() {
    while true; do
        clear_screen
        echo ""
        echo -e "${WHITE}╔═══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}║          G I T   Q U E S T                 ║${NC}"
        echo -e "${WHITE}╚═══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${CYAN}  1.${NC} ${WHITE}Start a New Game${NC}"
        echo -e "${CYAN}  2.${NC} ${WHITE}Chapter Select${NC}"
        echo -e "${CYAN}  3.${NC} ${WHITE}View Commands Reference${NC}"
        echo -e "${CYAN}  4.${NC} ${WHITE}Quit${NC}"
        echo ""
        echo -e "${YELLOW}════════════════════════════════════════════${NC}"
        echo ""
        read -p "Choose an option: " choice
        
        case $choice in
            1)
                play_game
                break
                ;;
            2)
                chapter_select
                ;;
            3)
                show_commands_reference
                ;;
            4)
                echo ""
                echo -e "${CYAN}Thanks for playing! Goodbye!${NC}"
                echo ""
                exit 0
                ;;
            *)
                echo ""
                echo -e "${RED}Invalid option. Try again!${NC}"
                echo ""
                sleep 1
                ;;
        esac
    done
}

show_commands_reference() {
    clear_screen
    echo ""
    echo -e "${WHITE}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${WHITE}║       C O M M A N D S   R E F E R E N C E  ║${NC}"
    echo -e "${WHITE}╚═══════════════════════════════════════════╝${NC}"
    echo ""
    
    cat << 'EOF'
  git init              Start a new Git repository
  git add <file>        Stage a file for commit
  git add .             Stage all changed files
  git commit -m "msg"   Commit staged changes with a message
  git status            Show working tree status
  git log               Show commit history
  git push              Push commits to remote
  git remote add <url>  Add a remote repository
  git branch <name>     Create a new branch
  git checkout <name>   Switch to a branch
  git merge <name>      Merge a branch into current
  git pull              Fetch and merge from remote
  
EOF
    
    echo -e "${GREEN}Press Enter to go back...${NC}"
    read -p "" dummy
}

play_game() {
    clear_screen
    
    # Display opening dialogue
    narrator_opening
    
    echo ""
    read -p "Press Enter to start Chapter 1..." dummy
    
    # Run all chapters
    chapter1_intro
    chapter2_intro
    chapter3_intro
    chapter4_intro
    chapter5_intro
    chapter6_intro
    chapter7_intro
    chapter8_intro
    chapter9_intro
    chapter10_intro
    chapter11_intro
    chapter12_intro
    chapter13_intro
    chapter14_intro
    chapter15_intro
    chapter16_intro
    chapter17_intro

    # Show completion screen
    show_completion_screen
    
    echo ""
    echo -e "${CYAN}Play again? (y/n)${NC}"
    read -p "" again
    
    if [[ "$again" == "y" || "$again" == "Y" ]]; then
        play_game
    else
        echo ""
        echo -e "${CYAN}Thanks for playing!${NC}"
        sleep 1
        exit 0
    fi
}

chapter_select() {
    while true; do
        clear_screen
        echo ""
        echo -e "${WHITE}╔═══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}║         C H A P T E R   S E L E C T        ║${NC}"
        echo -e "${WHITE}╚═══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${CYAN}  1.${NC} ${WHITE}Chapter 1: The Beginning${NC}"
        echo -e "${CYAN}  2.${NC} ${WHITE}Chapter 2: Staging Changes${NC}"
        echo -e "${CYAN}  3.${NC} ${WHITE}Chapter 3: Committing Changes${NC}"
        echo -e "${CYAN}  4.${NC} ${WHITE}Chapter 4: Working with History${NC}"
        echo -e "${CYAN}  5.${NC} ${WHITE}Chapter 5: Remote Repositories${NC}"
        echo -e "${CYAN}  6.${NC} ${WHITE}Chapter 6: Branching and Merging${NC}"
        echo -e "${CYAN}  7.${NC} ${WHITE}Chapter 7: Advanced Branching${NC}"
        echo -e "${CYAN}  8.${NC} ${WHITE}Chapter 8: Collaboration${NC}"
        echo -e "${CYAN}  9.${NC} ${WHITE}Chapter 9: Advanced Branching${NC}"
        echo -e "${CYAN} 10.${NC} ${WHITE}Chapter 10: Undoing Changes${NC}"
        echo -e "${CYAN} 11.${NC} ${WHITE}Chapter 11: Seeing the History${NC}"
        echo -e "${CYAN} 12.${NC} ${WHITE}Chapter 12: Temporarily Saving Changes${NC}"
        echo -e "${CYAN} 13.${NC} ${WHITE}Chapter 13: Seeing Specific Commits${NC}"
        echo -e "${CYAN} 14.${NC} ${WHITE}Chapter 14: Working with Branches${NC}"
        echo -e "${CYAN} 15.${NC} ${WHITE}Chapter 15: Advanced Branching Techniques${NC}"
        echo -e "${CYAN} 16.${NC} ${WHITE}Chapter 16: Rewriting History${NC}"
        echo -e "${CYAN} 17.${NC} ${WHITE}Chapter 17: Viewing Commit History${NC}"
        echo ""
        echo -e "${YELLOW}════════════════════════════════════════════${NC}"
        echo ""
        echo -e "${CYAN} 18.${NC} ${WHITE}Back to Main Menu${NC}"
        echo ""
        read -p "Choose a chapter (1-17): " choice
        
        case $choice in
            1)
                chapter1_intro
                ;;
            2)
                chapter2_intro
                ;;
            3)
                chapter3_intro
                ;;
            4)
                chapter4_intro
                ;;
            5)
                chapter5_intro
                ;;
            6)
                chapter6_intro
                ;;
            7)
                chapter7_intro
                ;;
            8)
                chapter8_intro
                ;;
            9)
                chapter9_intro
                ;;
            10)
                chapter10_intro
                ;;
            11)
                chapter11_intro
                ;;
            12)
                chapter12_intro
                ;;
            13)
                chapter13_intro
                ;;
            14)
                chapter14_intro
                ;;
            15)
                chapter15_intro
                ;;
            16)
                chapter16_intro
                ;;
            17)
                chapter17_intro
                ;;
            18)
                show_menu
                return
                ;;
            *)
                echo ""
                echo -e "${RED}Invalid option. Try again!${NC}"
                echo ""
                sleep 1
                ;;
        esac
    done
}

# ============================================================================
# START THE GAME
# ============================================================================

# Run title screen first
show_title_screen

# Then show main menu
show_menu
