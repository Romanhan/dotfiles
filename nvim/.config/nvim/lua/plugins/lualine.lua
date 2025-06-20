-- ~/.config/nvim/lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    -- Get Catppuccin colors for the mocha flavor
    local ctp_palette = require("catppuccin.palettes").get_palette("mocha")

    -- Load the base Catppuccin Lualine theme table
    -- This provides the shapes and default color mapping for sections.
    local lualine_catppuccin_theme = require("lualine.themes.catppuccin")

    -- Now, override the colors for specific modes/sections within this loaded theme
    -- This directly modifies the theme table before Lualine uses it.

    -- Normal mode
    lualine_catppuccin_theme.normal.a.fg = ctp_palette.crust -- Foreground for mode text
    lualine_catppuccin_theme.normal.a.bg = ctp_palette.green -- Background for mode section 'a'
    lualine_catppuccin_theme.normal.a.gui = "bold" -- Make it bold

    -- Insert mode
    lualine_catppuccin_theme.insert.a.fg = ctp_palette.crust
    lualine_catppuccin_theme.insert.a.bg = ctp_palette.blue
    lualine_catppuccin_theme.insert.a.gui = "bold"

    -- Visual mode
    lualine_catppuccin_theme.visual.a.fg = ctp_palette.crust
    lualine_catppuccin_theme.visual.a.bg = ctp_palette.pink
    lualine_catppuccin_theme.visual.a.gui = "bold"

    -- Command mode
    lualine_catppuccin_theme.command.a.fg = ctp_palette.crust
    lualine_catppuccin_theme.command.a.bg = ctp_palette.peach
    lualine_catppuccin_theme.command.a.gui = "bold"

    -- Replace mode
    lualine_catppuccin_theme.replace.a.fg = ctp_palette.crust
    lualine_catppuccin_theme.replace.a.bg = ctp_palette.maroon
    lualine_catppuccin_theme.replace.a.gui = "bold"

    return {
      options = {
        -- Set the theme to the *modified* Catppuccin theme table
        theme = lualine_catppuccin_theme,
        -- Other global Lualine options (optional, you can keep or adjust LazyVim defaults)
        icons_enabled = true,
        -- These separators come from the Catppuccin Lualine theme by default,
        -- but you can explicitly set them if you want specific ones.
        section_separators = { left = "", right = "" },
        -- component_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        always_divide_middle = true,
      },
      -- Define your Lualine sections (these are standard LazyVim defaults, adjust if needed)
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {}, -- Default LazyVim tabline is usually empty or defined elsewhere
      extensions = { "lazy", "nvim-tree" }, -- Example extensions
    }
  end,
}
