function web2app-browsers
    echo "🌐 Available browsers for web apps:"
    echo "==================================="
    
    # Check Wayland status
    set -l wayland_status "❌ X11"
    if test "$XDG_SESSION_TYPE" = "wayland" -o -n "$WAYLAND_DISPLAY"
        set wayland_status "✅ Wayland"
    end
    echo "🖥️  Display server: $wayland_status"
    echo ""
    
    set -l browsers zen-browser chromium google-chrome brave-browser firefox microsoft-edge-stable
    set -l found_any false
    
    for browser in $browsers
        if command -v $browser >/dev/null 2>&1
            set found_any true
            set -l version (eval "$browser --version 2>/dev/null | head -n1" 2>/dev/null || echo "version unknown")
            
            # Wayland support indicator
            set -l wayland_support ""
            switch $browser
                case "zen-browser" "firefox"
                    set wayland_support "🟢 Native Wayland"
                case "chromium" "google-chrome" "brave-browser" "microsoft-edge-stable"
                    set wayland_support "🟡 Ozone Wayland"
            end
            
            switch $browser
                case "zen-browser"
                    echo "  ✅ Zen Browser - $version ($wayland_support)"
                case "google-chrome"  
                    echo "  ✅ Google Chrome - $version ($wayland_support)"
                case "brave-browser"
                    echo "  ✅ Brave Browser - $version ($wayland_support)"
                case "microsoft-edge-stable"
                    echo "  ✅ Microsoft Edge - $version ($wayland_support)"
                case "*"
                    echo "  ✅ $browser - $version ($wayland_support)"
            end
        end
    end
    
    if not $found_any
        echo "  ❌ No supported browsers found"
        echo ""
        echo "💡 Install zen-browser with: yay -S zen-browser-bin"
    end
    
    echo ""
    echo "🔧 Wayland Support Legend:"
    echo "   🟢 Native Wayland = Best performance & compatibility"
    echo "   🟡 Ozone Wayland = Good performance via Chromium's Ozone"
end
