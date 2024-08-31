return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local path_ok, plenary_path = pcall(require, "plenary.path")
    if not path_ok then
      return
    end

    local dashboard = require("alpha.themes.dashboard")
    local cdir = vim.fn.getcwd()
    local if_nil = vim.F.if_nil

    local nvim_web_devicons = {
      enabled = true,
      highlight = true,
    }

    local function get_extension(fn)
      local match = fn:match("^.+(%..+)$")
      local ext = ""
      if match ~= nil then
        ext = match:sub(2)
      end
      return ext
    end

    local function icon(fn)
      local nwd = require("nvim-web-devicons")
      local ext = get_extension(fn)
      return nwd.get_icon(fn, ext, { default = true })
    end

    local function file_button(fn, sc, short_fn, autocd)
      short_fn = short_fn or fn
      local ico_txt
      local fb_hl = {}

      if nvim_web_devicons.enabled then
        local ico, hl = icon(fn)
        local hl_option_type = type(nvim_web_devicons.highlight)
        if hl_option_type == "boolean" then
          if hl and nvim_web_devicons.highlight then
            table.insert(fb_hl, { hl, 0, #ico })
          end
        end
        if hl_option_type == "string" then
          table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
        end
        ico_txt = ico .. "  "
      else
        ico_txt = ""
      end
      local cd_cmd = (autocd and " | cd %:p:h" or "")
      local file_button_el = dashboard.button(sc, ico_txt .. short_fn,
        "<cmd>e " .. vim.fn.fnameescape(fn) .. cd_cmd .. " <CR>")
      local fn_start = short_fn:match(".*[/\\]")
      if fn_start ~= nil then
        table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
      end
      file_button_el.opts.hl = fb_hl
      return file_button_el
    end

    local default_mru_ignore = { "gitcommit" }

    local mru_opts = {
      ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
      end,
      autocd = false
    }

    --- @param start number
    --- @param cwd string? optional
    --- @param items_number number? optional number of items to generate, default = 10
    local function mru(start, cwd, items_number, opts)
      opts = opts or mru_opts
      items_number = if_nil(items_number, 10)

      local oldfiles = {}
      for _, v in pairs(vim.v.oldfiles) do
        if #oldfiles == items_number then
          break
        end
        local cwd_cond
        if not cwd then
          cwd_cond = true
        else
          cwd_cond = vim.startswith(v, cwd)
        end
        local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
        if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
          oldfiles[#oldfiles + 1] = v
        end
      end
      local target_width = 35

      local tbl = {}
      for i, fn in ipairs(oldfiles) do
        local short_fn
        if cwd then
          short_fn = vim.fn.fnamemodify(fn, ":.")
        else
          short_fn = vim.fn.fnamemodify(fn, ":~")
        end

        if #short_fn > target_width then
          short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
          if #short_fn > target_width then
            short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
          end
        end

        local shortcut = tostring(i + start - 1)

        local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
        tbl[i] = file_button_el
      end
      return {
        type = "group",
        val = tbl,
        opts = {},
      }
    end

    local header = {
      type = "text",
      val = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠐⠒⠒⠒⠂⠀⠤⠤⠤⣄⣀⡀⠘⢆⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⡿⠋⣀⣔⣒⣉⣀⠤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠎⠀⣀⣀⡤⠤⠤⠄⠀⠒⠒⠒⠒⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣉⣽⢾⡇⠀⠀⠀⠀⠀⢰⣿⣟⣵⣿⢿⣿⣛⣿⣿⣻⢿⣦⠤⠀⠀⠀⠀⠀⠀⠀⠠⣾⢾⣍⣁⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⡴⠶⠛⠋⠉⠁⠀⢠⡏⠀⠀⠀⠀⠰⣲⡿⡟⠋⢹⣿⠟⠛⠉⠉⠙⢻⣗⢻⣇⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⠀⠀⠉⠉⠛⠳⠶⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⢀⣤⠶⠟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠁⢀⡴⠋⠀⠀⠀⠀⠀⢀⠿⣿⣸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡆⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠶⢦⣀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢀⣠⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣟⣿⡟⣿⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢦⡀⠀⠀⠀",
        "⠀⠀⣴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⣶⣿⣾⣾⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⡄⠀",
        "⠀⣼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠖⠚⠛⣛⠻⢧⣤⣤⣄⣀⡠⣤⣤⣶⣶⣶⣾⣿⣿⣳⣝⣿⡿⣻⣽⢺⣿⣿⣿⣶⣶⣶⡤⣀⣤⣤⣤⠟⢛⡛⠛⠒⠶⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄",
        "⢰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠋⠀⠀⠀⠀⡴⠁⠀⠀⠀⠉⠉⠛⠛⠾⠯⣟⣻⡿⠿⣟⣯⣿⣿⣷⣿⣿⡇⡏⣻⣿⣟⡿⠯⠗⠛⠋⠉⠁⠀⠀⠀⠱⡄⠀⠀⠀⠈⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧",
        "⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣾⣯⣹⣷⣝⢿⣿⣿⣻⣵⣏⣿⣧⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⠀⠀⠀⠀⢸",
        "⢸⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠯⣷⣿⣿⣿⣷⣷⣿⣿⣽⣸⡯⠏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⢁⠀⠀⠀⠀⠀⠀⠀⠀⢸",
        "⢸⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡉⠩⡏⡏⣟⢿⡿⣿⣽⣇⡯⠉⡉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⢸",
        "⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⡇⣿⣷⣿⣿⢿⠏⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸",
        "⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣶⢶⣶⢄⠀⠀⢠⣾⢻⣿⣽⣯⣿⣸⣸⣿⣆⠀⠀⣠⢴⣶⢶⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆",
        "⠀⢁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⣾⣯⣿⢸⣷⣄⣴⣯⡺⣝⡿⡿⣿⣽⡿⣻⣶⢀⣾⣧⢿⡞⣿⣽⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁",
        "⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠟⠈⠇⠀⠙⢿⣯⠟⠀⢏⣿⣿⣿⡟⣇⠹⢿⣿⠟⠁⠸⠃⠸⠃⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀",
        "⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠘⣼⣽⣿⣦⣿⠀⠈⠀⠀⠀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⣟⣿⣯⡼⡧⣴⣶⣿⠿⠿⠿⠿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡜⡿⡿⣫⣻⡝⠒⠉⠉⠈⠈⠉⠉⠘⠙⢿⣿⣏⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⢿⠟⠘⣿⣿⣗⣻⣦⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⢧⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠲⣤⣀⣀⣀⣀⣀⣠⣤⣶⣾⡿⠿⠛⠉⠀⠀⠀⠀⠀⢺⣿⣷⣝⢿⣶⣄⣀⡀⠀⠠⢴⣿⣽⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⢿⣶⣝⡿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      },
      opts = {
        position = "center",
        hl = "AlphaHeader",
        -- wrap = "overflow";
      },
    }

    local section_mru = {
      type = "group",
      val = {
        {
          type = "text",
          val = "Recent files",
          opts = {
            hl = "SpecialComment",
            shrink_margin = false,
            position = "center",
          },
        },
        { type = "padding", val = 0 },
        {
          type = "group",
          val = function()
            return { mru(0, cdir) }
          end,
          opts = { shrink_margin = false },
        },
      },
    }
    local symbolColor = "#cc241d"

    local buttons = {
      type = "group",
      val = {
        { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 0 },
        dashboard.button("n", " " .. "New file", "<cmd> ene <BAR> startinsert <cr>"),
        dashboard.button("f", "󰈞 " .. "Find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("g", "󰊄 " .. "Live grep", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("r", " " .. "Recent files", "<cmd> Telescope oldfiles <cr>"),
        dashboard.button("o", "󰇈 " .. "Obsidian", "<cmd>cd ~/notes_vault/personal<CR>"),
        dashboard.button("c", " " .. "Configuration", "<cmd>cd ~/.config/nvim/<CR><cmd>edit $MYVIMRC<CR>"),
        dashboard.button("u", " " .. "Update plugins", "<cmd>Lazy sync<CR>"),
        dashboard.button("l", "󰒲 " .. "Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. "Quit", "<cmd>qa<CR>"),
      },
      position = "center",
    }
    local footer = {
      type = "text",
      val = function()
        return "[" .. cdir .. "]"
      end,
      opts = {
        position = "center",
        hl = "AlphaFooter"
      },
    }

    local config = {
      layout = {
        header,
        { type = "padding", val = 2 },
        buttons,
        { type = "padding", val = 2 },
        section_mru,
        { type = "padding", val = 2 },
        -- footer,
      },
      opts = {
        margin = 5,
        setup = function()
          vim.api.nvim_create_autocmd('DirChanged', {
            pattern = '*',
            group = "alpha_temp",
            callback = function()
              cdir = vim.fn.getcwd()
              require('alpha').redraw()
              vim.cmd('AlphaRemap')
            end,
          })
        end,
      },
    }

    require 'alpha'.setup(config)
  end
}

-- return {
--   "goolord/alpha-nvim",
--   event = "VimEnter",
--   enabled = true,
--   init = false,
--   opts = function()
--     local dashboard = require("alpha.themes.dashboard")
--     local logo = [[
--       ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
--       ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
--       ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
--       ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
--       ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
--       ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
--     ]]
--
--     -- dashboard.section.header.val = {
--     --    [[=================     ===============     ===============   ========  ========]],
--     --    [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
--     --    [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
--     --    [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
--     --    [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
--     --    [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
--     --    [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
--     --    [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
--     --    [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
--     --    [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
--     --    [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
--     --    [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
--     --    [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
--     --    [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
--     --    [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
--     --    [[||.=='    _-'                                                     `' |  /==.||]],
--     --    [[=='    _-'                        N E O V I M                         \/   `==]],
--     --    [[\   _-'                                                                `-_   /]],
--     --    [[ `''                                                                      ``' ]],
--     -- }
--     dashboard.section.header.val = vim.split(logo, "\n")
--
--     dashboard.section.buttons.val = {
--       dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
--       dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
--       dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
--       dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
--       dashboard.button("c", " " .. " Config", "<cmd>edit $MYVIMRC<CR>"),
--       dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
--       dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
--     }
--     for _, button in ipairs(dashboard.section.buttons.val) do
--       button.opts.hl = "AlphaButtons"
--       button.opts.hl_shortcut = "AlphaShortcut"
--     end
--     dashboard.section.header.opts.hl = "AlphaHeader"
--     dashboard.section.buttons.opts.hl = "AlphaButtons"
--     dashboard.section.footer.opts.hl = "AlphaFooter"
--     dashboard.opts.layout[1].val = 8
--     return dashboard
--   end,
--   config = function(_, dashboard)
--     -- close Lazy and re-open when the dashboard is ready
--     if vim.o.filetype == "lazy" then
--       vim.cmd.close()
--       vim.api.nvim_create_autocmd("User", {
--         once = true,
--         pattern = "AlphaReady",
--         callback = function()
--           require("lazy").show()
--         end,
--       })
--     end
--
--     require("alpha").setup(dashboard.opts)
--
--     vim.api.nvim_create_autocmd("User", {
--       once = true,
--       pattern = "LazyVimStarted",
--       callback = function()
--         local stats = require("lazy").stats()
--         local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
--         dashboard.section.footer.val = "⚡ Neovim loaded "
--             .. stats.loaded
--             .. "/"
--             .. stats.count
--             .. " plugins in "
--             .. ms
--             .. "ms"
--         pcall(vim.cmd.AlphaRedraw)
--       end,
--     })
--   end,
-- }
