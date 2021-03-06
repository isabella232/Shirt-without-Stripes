#!/usr/bin/env bash
# get current state and save them in a subfolder with date

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TODAY=$(date +20%y-%m-%d)
DEST="screenshots/$TODAY"

function log {
    printf "%s : %s\n" "$(date +'%F %T' )" "$@" | tee -a "$SCRIPT_DIR/update.log"
}

mkdir -p "$DEST"
cd "$DEST" || exit

declare -A SITES
SITES["amazon"]="https://www.amazon.com/s?k=shirt+without+stripes"
SITES["bing"]="https://www.bing.com/images/search?q=shirt+without+stripes"
SITES["google"]="https://www.google.com/search?q=shirt+without+stripes&tbm=isch"

for COMPANY in "${!SITES[@]}"; do
    log "Getting current state of $COMPANY"
    log "$( chromium-browser \
        --headless \
        --disable-gpu \
        --hide-scrollbars \
        --window-size=1000,1000 \
        --screenshot="$COMPANY.png" "${SITES[$COMPANY]}" 2>&1 )"
done
