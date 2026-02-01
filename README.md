# Git Quest

**A terminal-based, interactive BASH game to learn Git fundamentals**

Git Quest is a playful, interactive terminal game designed to teach Git basics through hands-on practice in a sarcastic but helpful environment. 

## 🎮 Game Overview

In Git Quest, you play as a developer who "lied on their resume" about Git knowledge. The game guides you through 17 chapters, each teaching essential Git commands from initialization to branching and merging.

## 🚀 Features

- **Interactive Learning**: Practice Git commands in a safe, simulated environment
- **Sarcastic Narrator**: A condescending yet helpful narrator provides guidance
- **Smart Validation**: Flexible command matching with helpful hints
- **Fake Git Output**: Realistic simulation of Git command responses
- **Terminal UI**: Color-coded interface with consistent styling
- **Cross-Platform**: Compatible with both Linux and macOS

## 📋 How It Works

> ⚠️ **Important**: This game doesn't create any files or projects on your computer. Everything is simulated entirely in the terminal.

The game provides a safe environment to practice Git commands without risk of affecting your actual repositories. All file operations are simulated, and no real files are created or modified.

## 🛠️ Requirements

- Bash (version 4 or higher)
- Git (for reference only - not required to run the game)

## 🎯 Learning Progression

1. `git init` - Repository initialization
2. `git add` - Staging changes
3. `git commit` - Committing changes
4. `git status` & `git log` - Status checking and history
5. Remote repositories - `git push` and remotes
6. `git branch` - Branching concepts
7. `git checkout` - Branch switching
8. `git merge` - Branch merging

## 🚀 Getting Started

1. Clone or download this repository
2. Make the main script executable:
   ```bash
   chmod +x git-quest.sh
   ```
3. Run the game:
   ```bash
   ./git-quest.sh
   ```

## 📁 Project Structure

- `git-quest.sh` - Main game orchestrator
- `chapters/` - 17 chapter files teaching specific Git concepts
- `lib/` - Library modules for UI, validation, and narration

## 🌍 Cross-Platform Compatibility

Git Quest is designed to work on both Linux and macOS systems. The game uses standard BASH features and terminal capabilities that are available on both platforms.


## 📬 Support

For support or questions, please open an issue on the GitHub repository.
