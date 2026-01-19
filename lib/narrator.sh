#!/bin/bash

# ============================================================================
# NARRATOR LIBRARY
# The voice of the game - a snarky but helpful terminal
# ============================================================================

# Source dependencies if not already sourced
if [[ -z "$NC" ]]; then
    source "$(dirname "$0")/colors.sh"
fi

# ============================================================================
# NARRATOR DIALOGUE FUNCTIONS
# ============================================================================

# Start narrator speech
narrator_speak() {
    local text="$1"
    echo -e "${CYAN}$text${NC}"
    echo ""
}

# Narrator with emoji prefix
narrator_with_prefix() {
    local emoji="$1"
    local text="$2"
    echo -e "${CYAN}$emoji $text${NC}"
    echo ""
}

# Disappointed narrator
narrator_disappointed() {
    local text="$1"
    echo -e "${YELLOW}😤 ... $text${NC}"
    echo ""
}

# Encouraging narrator
narrator_encourage() {
    local text="$1"
    echo -e "${GREEN}🌟 $text${NC}"
    echo ""
}

# Narrator warning
narrator_warning() {
    local text="$1"
    echo -e "${YELLOW}⚠️  $text${NC}"
    echo ""
}

# Narrator celebration
narrator_celebrate() {
    local text="$1"
    echo -e "${GREEN}🎉 $text${NC}"
    echo ""
}

# Narrator secret/shh
narrator_secret() {
    local text="$1"
    echo -e "${PURPLE}🤫 $text${NC}"
    echo ""
}

# Narrator facepalm
narrator_facepalm() {
    local text="$1"
    echo -e "${RED}🤦 $text${NC}"
    echo ""
}

# Random encouraging comment
narrator_encouraging_comment() {
    local comments=(
        "Not bad! Not bad at all."
        "You're getting the hang of this!"
        "That's actually pretty good!"
        "You're on the right track!"
        "Keep it up! You've got this!"
        "I'm impressed - you're not completely terrible!"
        "That's a solid attempt!"
        "You're making progress, I can see it!"
        "You're learning! Congratulations!"
        "I didn't think you had it in you!"
    )
    
    local random_index=$((RANDOM % ${#comments[@]}))
    echo -e "${GREEN}👍 ${comments[$random_index]}${NC}"
    echo ""
}

# Narrator question
narrator_question() {
    local text="$1"
    echo -e "${BLUE}🤔 $text${NC}"
    echo ""
}

# Random sarcastic comment
narrator_sarcastic_comment() {
    local comments=(
        "Oh, you're trying to learn Git? How... quaint."
        "I've seen more sophisticated code in a toaster."
        "Wow, you're really going to need a hint for this one."
        "This is why we can't have nice things."
        "I've seen monkeys with better Git skills than you."
        "Don't worry, I've been in your shoes. Well, not literally, but you get the point."
        "This is the part where you realize you're not a genius."
        "I'm starting to think you're just pretending to be confused."
        "This is what happens when you don't read the manual."
        "You know, I've seen more creative solutions to this problem in my dreams."
    )
    
    local random_index=$((RANDOM % ${#comments[@]}))
    echo -e "${YELLOW}🙄 ${comments[$random_index]}${NC}"
    echo ""
}

# ============================================================================
# SPECIAL NARRATOR MOMENTS
# ============================================================================

# When player gets it wrong
narrator_wrong_answer() {
    local attempt="$1"
    local correct_answer="$2"
    
    echo -e "${RED}❌ NOPE. That's not it.${NC}"
    echo ""
    echo -e "${YELLOW}You tried:${NC} ${WHITE}$attempt${NC}"
    echo ""
    echo -e "${GREEN}Try again, or type 'hint' for help!${NC}"
    echo ""
}

# Show correct answer
narrator_show_answer() {
    local answer="$1"
    echo ""
    echo -e "${YELLOW}Okay, fine. I'll tell you.${NC}"
    echo ""
    echo -e "${CYAN}The correct command is:${NC}"
    echo ""
    echo -e "    ${GREEN}$answer${NC}"
    echo ""
    echo -e "${YELLOW}Now go try it! And this time, get it right!${NC}"
    echo ""
}

# Chapter complete celebration
narrate_chapter_complete() {
    local chapter="$1"
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                               ║${NC}"
    echo -e "${GREEN}║${NC}   🎉  CHAPTER $chapter COMPLETE!  🎉                           ${GREEN}║${NC}"
    echo -e "${GREEN}║                                                               ║${NC}"
    echo -e "${GREEN}║${NC}   You're one step closer to keeping your job!              ${GREEN}║${NC}"
    echo -e "${GREEN}║                                                               ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Level failed (just kidding)
narrate_failed() {
    local chapter="$1"
    echo ""
    echo -e "${YELLOW}😬 You failed... or did you?${NC}"
    echo ""
    echo -e "${CYAN}In Git, there's no real failure - just learning opportunities!${NC}"
    echo ""
    echo -e "${GREEN}Let's try this again, shall we?${NC}"
    echo ""
}

# Narrator intro for a chapter
narrator_chapter_intro() {
    local chapter="$1"
    local title="$2"
    
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}║${NC}  CHAPTER $chapter: $title"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

# ============================================================================
# SPECIFIC NARRATOR QUOTES
# ============================================================================

narrator_opening() {
    cat << 'EOF'
🗣️  "Oh great, a new hire. Let me guess... you clicked 'git push' 
    without understanding what it does, didn't you? I've seen 
    it before. We're going to fix that.
    
    I'm your guide. Your mentor. Your slightly condescending 
    but ultimately helpful terminal.
    
    Let's get you from 'I fake it' to 'I actually know what 
    I'm doing.' But first... we need to understand what Git 
    actually IS.
    
    So, what IS Git? Let me put it this way:
    
    Without Git: You're writing a document. You save it. 
    You change it. You save it again. Now you have 
    'final.doc', 'final_final.doc', 'final_final_REAL.doc'.
    Your folder is a mess.
    
    With Git: Every change is tracked. You can go back. 
    You can branch off to experiment. You can merge 
    changes together. It's like having a time machine 
    for your code.
    
    Git is a VERSION CONTROL SYSTEM. It tracks changes 
    to files over time.
    
    Ready to learn? Let's begin!"
EOF
}

what_is_git() {
    cat << 'EOF'
🗣️  "So, what IS Git? Let me put it this way:
    
    Without Git: You're writing a document. You save it. 
    You change it. You save it again. Now you have 
    'final.doc', 'final_final.doc', 'final_final_REAL.doc'.
    Your folder is a mess.
    
    With Git: Every change is tracked. You can go back. 
    You can branch off to experiment. You can merge 
    changes together. It's like having a time machine 
    for your code.
    
    Git is a VERSION CONTROL SYSTEM. It tracks changes 
    to files over time."
EOF
}

narrator_explain_init() {
    cat << 'EOF'
🗣️  "Before you can use Git, you need to... wait for it... 
    INITIALIZE it.
    
    Think of it like moving into a new house. You can't 
    start decorating until you actually have the keys 
    and open the door.
    
    git init creates a hidden folder called .git in your 
    project. This folder is where Git stores all its 
    magic - the history, the branches, everything.
    
    It's the birthplace of your Git repository!"
EOF
}

narrator_explain_add() {
    cat << 'EOF'
🗣️  "Okay, so you've made some changes to your files. Now what?
    
    Git has this concept called the 'staging area'. It's 
    like a loading dock where you prepare your changes 
    before they become permanent.
    
    git add tells Git 'hey, pay attention to this file, 
    I might want to save it in the next commit.'
    
    You add files to the staging area FIRST, then you 
    commit them together. It's like staging photos for 
    a photo album before printing them.
    
    Pro tip: git add . adds EVERYTHING. But be careful..."
EOF
}

narrator_explain_commit() {
    cat << 'EOF'
🗣️  "Alright, you've staged your changes. Now it's time to 
    make them permanent.
    
    A commit is like taking a snapshot of your project 
    at a specific moment. It's saved in the history 
    forever (unless you really mess things up).
    
    The -m flag lets you add a message. ALWAYS write 
    meaningful commit messages! Future you will thank 
    present you.
    
    Good: 'Add user login functionality'
    Bad: 'stuff' or 'fixed it' or 'update'
    
    Pro tip: A commit message should complete the sentence 
    'This commit will...' "
EOF
}

narrator_explain_status() {
    cat << 'EOF'
🗣️  "Feeling lost? Haven't the foggiest where you are?
    
    git status is your best friend. It tells you:
    
    1. Which files have been changed
    2. Which files are staged (ready to commit)
    3. Which files aren't being tracked at all
    
    Red text = not staged
    Green text = staged and ready to commit
    Clean message = everything is committed!
    
    Use it. Love it. git status often."
EOF
}

narrator_explain_log() {
    cat << 'EOF'
🗣️  "Want to see where you've been? git log shows you the 
    entire history of commits in your repository.
    
    Each commit has:
    - A unique ID (that long hash)
    - The author
    - The date
    - Your commit message
    
    It's like a journal of your project's life. You can 
    scroll through it with the arrow keys, and press 'q' 
    to get back to the terminal.
    
    Pro tip: q is how you quit most Git displays!"
EOF
}

narrator_explain_push() {
    cat << 'EOF'
🗣️  "So you've been working locally. But what if your laptop 
    gets stolen? Or you want to share code with others?
    
    Enter git push - the moment of truth!
    
    Push sends your committed changes from your local 
    repository to a remote one (like GitHub, GitLab, etc.)
    
    Think of it like:
    - Local repo = your local machine
    - Remote repo = the cloud or shared server
    
    Before pushing for the first time, you'll need to set 
    up the remote. But I'll get to that..."
EOF
}

narrator_explain_branch() {
    cat << 'EOF'
🗣️  "Branches are one of Git's most powerful features.
    
    A branch is like a parallel universe for your code. 
    You can make changes there without affecting the 
    main code.
    
    The main branch is usually called 'main' or 'master'.
    It's the production-ready code.
    
    When you want to add a feature or fix a bug:
    1. Create a new branch
    2. Make your changes
    3. Test them
    4. Merge them back into main
    
    This way, your main code stays stable while you 
    experiment!"
EOF
}

narrator_explain_merge() {
    cat << 'EOF'
🗣️  "You've created branches, made changes... now what?
    
    git merge brings branches back together!
    
    When you merge, you're combining the changes from 
    one branch into another.
    
    There are two types of merges:
    1. Fast-forward - when there are no conflicts
    2. Merge commit - when Git can't automatically 
       combine changes and needs human help
    
    Don't worry about merge conflicts for now. They're 
    just Git saying 'I don't know which change to keep, 
    you decide.' We'll cover that later... maybe."
EOF
}

narrator_encouragement() {
    cat << 'EOF'
🗣️  "Hey, it's okay. Everyone starts somewhere.
    
    I once saw someone type 'git commit' without -m and 
    accidentally open Vim. They were stuck for 20 minutes 
    before a senior dev saved them.
    
    You're doing fine. Keep trying. I'm not going anywhere.
    
    (Unlike some of your code will after this project... 
    I'm kidding. Sort of.)"
EOF
}

narrator_final() {
    cat << 'EOF'
🗣️  "Well, well, well... look at you! You've actually 
    learned something!
    
    You now know the basics of Git. Is it everything? 
    No. Git has more commands than you can shake a 
    stick at.
    
    But you've got the foundation. The rest you can 
    Google as needed (we all do).
    
    Remember:
    • git init    - Start a repo
    • git add     - Stage changes
    • git commit  - Save changes
    • git status  - Check your work
    • git log     - See history
    • git push    - Share your work
    • git branch  - Create parallel universes
    • git merge   - Bring universes together
    
    Now go forth and commit! And maybe... don't lie 
    on your next resume. I'm just saying."
EOF
}
