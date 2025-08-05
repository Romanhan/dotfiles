# Remove the default Fish greeting message that shows on shell startup
set fish_greeting

# Initialize Starship prompt (replaces default Fish prompt with customizable one)
starship init fish | source

# Only run these commands in interactive shell sessions (not in scripts)
if status is-interactive
    # Commands to run in interactive sessions can go here
    # (currently empty - add aliases, key bindings, etc. here)
end

# Check if SSH agent is not already running (SSH_AUTH_SOCK variable doesn't exist)
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) >/dev/null
    ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1
end

# Load Rust Cargo environment (adds cargo binaries to PATH)
source "$HOME/.cargo/env.fish"
