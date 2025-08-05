# Main web2app function - other functions are in separate files
function web2app
    if test (count $argv) -lt 3
        echo "Usage: web2app <AppName> <AppURL> <IconURL> [browser]"
        echo "Supported browsers: zen, chromium, chrome, firefox, brave, edge"
        echo "IconURL must be in PNG format -- use https://dashboardicons.com"
        return 1
    end

    set -l APP_NAME $argv[1]
    set -l APP_URL $argv[2]
    set -l ICON_URL $argv[3]
    set -l BROWSER $argv[4]
    set -l ICON_DIR "$HOME/.local/share/applications/icons"
    set -l DESKTOP_FILE "$HOME/.local/share/applications/$APP_NAME.desktop"
    set -l ICON_PATH "$ICON_DIR/$APP_NAME.png"

    # Auto-detect browser if not specified
    if test -z "$BROWSER"
        set BROWSER (detect_browser)
        if test -z "$BROWSER"
            echo "❌ No supported browser found!"
            echo "Install one of: zen-browser, chromium, google-chrome, firefox, brave, microsoft-edge"
            return 1
        end
        echo "🔍 Auto-detected browser: $BROWSER"
    end

    # Create icon directory
    mkdir -p "$ICON_DIR"

    # Download icon
    echo "📥 Downloading icon for $APP_NAME..."
    if not curl -sL -o "$ICON_PATH" "$ICON_URL"
        echo "❌ Error: Failed to download icon."
        return 1
    end

    # Get browser command
    set -l exec_command (get_browser_command "$BROWSER" "$APP_URL" "$APP_NAME")
    if test -z "$exec_command"
        echo "❌ Error: Unsupported browser '$BROWSER'"
        return 1
    end

    # Create desktop file
    echo "🚀 Creating desktop launcher for $APP_NAME..."
    echo "[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=$APP_NAME Web App
Exec=$exec_command
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;app;$APP_NAME;" > "$DESKTOP_FILE"

    # Make executable
    chmod +x "$DESKTOP_FILE"
    
    echo "✅ Desktop app '$APP_NAME' created successfully!"
    echo "📍 Launcher: $DESKTOP_FILE"  
    echo "🎨 Icon: $ICON_PATH"
    echo "🌐 Browser: $BROWSER"
    echo "🚀 The app should appear in your application menu"
end

# Helper function: Detect available browser
function detect_browser
    # Check browsers in order of preference for web apps
    set -l browsers zen-browser chromium google-chrome brave-browser firefox microsoft-edge-stable
    
    for browser in $browsers
        if command -v $browser >/dev/null 2>&1
            switch $browser
                case "zen-browser"
                    echo "zen"
                case "google-chrome"
                    echo "chrome"  
                case "brave-browser"
                    echo "brave"
                case "microsoft-edge-stable"
                    echo "edge"
                case "*"
                    echo $browser
            end
            return 0
        end
    end
    
    # Return empty if none found
    return 1
end

# Helper function: Get browser-specific command with Wayland support
function get_browser_command
    set -l browser $argv[1]
    set -l url $argv[2] 
    set -l app_name $argv[3]
    
    # Check if we're running on Wayland
    set -l wayland_flags ""
    if test "$XDG_SESSION_TYPE" = "wayland" -o -n "$WAYLAND_DISPLAY"
        set wayland_flags "--ozone-platform=wayland"
    end
    
    switch $browser
        case "zen" "zen-browser"
            # Zen browser (Firefox-based) - set Wayland environment
            if test -n "$wayland_flags"
                echo "env MOZ_ENABLE_WAYLAND=1 zen-browser --new-window --name=\"$app_name\" --class=\"$app_name\" \"$url\""
            else
                echo "zen-browser --new-window --name=\"$app_name\" --class=\"$app_name\" \"$url\""
            end
            
        case "chromium"
            echo "chromium --new-window $wayland_flags --app=\"$url\" --name=\"$app_name\" --class=\"$app_name\""
            
        case "chrome" "google-chrome"
            echo "google-chrome --new-window $wayland_flags --app=\"$url\" --name=\"$app_name\" --class=\"$app_name\""
            
        case "firefox"
            # Firefox - set Wayland environment and use new window mode
            if test -n "$wayland_flags"
                echo "env MOZ_ENABLE_WAYLAND=1 firefox --new-window --name=\"$app_name\" --class=\"$app_name\" \"$url\""
            else
                echo "firefox --new-window --name=\"$app_name\" --class=\"$app_name\" \"$url\""
            end
            
        case "brave"
            echo "brave-browser --new-window $wayland_flags --app=\"$url\" --name=\"$app_name\" --class=\"$app_name\""
            
        case "edge"
            echo "microsoft-edge-stable --new-window $wayland_flags --app=\"$url\" --name=\"$app_name\" --class=\"$app_name\""
            
        case "*"
            # Return empty for unsupported browsers
            return 1
    end
end
