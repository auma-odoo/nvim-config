return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "  ██████   ███████    ██████    ██████ ",
        " ██    ██  ██    ██  ██    ██  ██    ██",
        " ██    ██  ██    ██  ██    ██  ██    ██",
        " ██    ██  ██    ██  ██    ██  ██    ██",
        "  ██████   ███████    ██████    ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      -- opts.section.buttons.val = {
      --   opts.button("h", "  Say Hi", ":echo Hello World!"),
      -- }
      return opts
    end,
  },
}
