return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,     -- Very high priority to ensure it loads first
    opts = {
      rocks = { "fzy" }, -- Example rock; adjust as needed
    },
  },
}
