#!/bin/bash

# ============================================================================
# COLORS LIBRARY
# Terminal color codes for UI styling
# ============================================================================

# Reset
NC='\033[0m' # No Color

# Regular Colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bold
BBLACK='\033[1;30m'
BRED='\033[1;31m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
BPURPLE='\033[1;35m'
BCYAN='\033[1;36m'
BWHITE='\033[1;37m'

# Underline
UBLACK='\033[4;30m'
URED='\033[4;31m'
UGREEN='\033[4;32m'
UYELLOW='\033[4;33m'
UBLUE='\033[4;34m'
UPURPLE='\033[4;35m'
UCYAN='\033[4;36m'
UWHITE='\033[4;37m'

# Background
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# High Intensity
IBLACK='\033[0;90m'
IRED='\033[0;91m'
IGREEN='\033[0;92m'
IYELLOW='\033[0;93m'
IBLUE='\033[0;94m'
IPURPLE='\033[0;95m'
ICYAN='\033[0;96m'
IWHITE='\033[0;97m'

# Bold High Intensity
BIBLACK='\033[1;90m'
BIRED='\033[1;91m'
BIGREEN='\033[1;92m'
BIYELLOW='\033[1;93m'
BIBLUE='\033[1;94m'
BIPURPLE='\033[1;95m'
BICYAN='\033[1;96m'
BIWHITE='\033[1;97m'

# High Intensity Background
BG_IBLACK='\033[0;100m'
BG_IRED='\033[0;101m'
BG_IGREEN='\033[0;102m'
BG_IYELLOW='\033[0;103m'
BG_IBLUE='\033[0;104m'
BG_IPURPLE='\033[0;105m'
BG_ICYAN='\033[0;106m'
BG_IWHITE='\033[0;107m'

# ============================================================================
# COLOR HELPER FUNCTIONS
# ============================================================================

# Check if terminal supports colors
supports_colors() {
    if [[ -t 1 ]]; then
        if [[ -n "$TERM" && "$TERM" != "dumb" ]]; then
            return 0
        fi
    fi
    return 1
}

# Print colored text (with fallback for no color support)
print_color() {
    local color="$1"
    local text="$2"
    if supports_colors; then
        echo -e "${color}${text}${NC}"
    else
        echo "$text"
    fi
}

# Print success message (green)
print_success() {
    if supports_colors; then
        echo -e "${GREEN}✓ $1${NC}"
    else
        echo "[OK] $1"
    fi
}

# Print error message (red)
print_error() {
    if supports_colors; then
        echo -e "${RED}✗ $1${NC}"
    else
        echo "[ERROR] $1"
    fi
}

# Print warning message (yellow)
print_warning() {
    if supports_colors; then
        echo -e "${YELLOW}⚠ $1${NC}"
    else
        echo "[WARNING] $1"
    fi
}

# Print info message (cyan)
print_info() {
    if supports_colors; then
        echo -e "${CYAN}ℹ $1${NC}"
    else
        echo "[INFO] $1"
    fi
}
