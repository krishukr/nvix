{ config, helpers, ... }:
let
  inherit (config.nvix.mkKey) mkKeymap mkKeymapWithOpts wKeyObj;
  # Set of General mappings not dependent on any plugins
  v = [

    (mkKeymap "v" "<c-s>" "<esc>:w<cr>" "Saving File")
    (mkKeymap "v" "<c-c>" "<esc>" "Escape")

    (mkKeymap "v" "<a-j>" ":m '>+1<cr>gv-gv" "Move Selected Line Down")
    (mkKeymap "v" "<a-k>" ":m '<lt>-2<CR>gv-gv" "Move Selected Line Up")

    (mkKeymap "v" "<" "<gv" "Indent out")
    (mkKeymap "v" ">" ">gv" "Indent in")

    (mkKeymap "v" "<space>" "<Nop>" "Mapped to Nothing")
  ];

  xv = [
    (mkKeymapWithOpts "x" "j" ''v:count || mode(1)[0:1] == "no" ? "j" : "gj"'' "Move down" {
      expr = true;
    })
    (mkKeymapWithOpts "x" "k" ''v:count || mode(1)[0:1] == "no" ? "k" : "gk"'' "Move up" {
      expr = true;
    })
  ];

  insert = [
    (mkKeymap "i" "jk" "<esc>" "Normal Mode")
    (mkKeymap "i" "<c-s>" "<esc>:w ++p<cr>" "Save file")
    (mkKeymap "i" "<a-j>" "<esc>:m .+1<cr>==gi" "Move Line Down")
    (mkKeymap "i" "<a-k>" "<esc>:m .-2<cr>==gi" "Move Line Up")
  ];

  normal = [
    (mkKeymap "n" "<c-s>" "<cmd>w ++p<cr>" "Save the file")
    (mkKeymap "n" "<c-a-=>" "<C-a>" "Increase Number")
    (mkKeymap "n" "<c-a-->" "<C-x>" "Decrease Number")

    (mkKeymap "n" "<a-j>" "<cmd>m .+1<cr>==" "Move line Down")
    (mkKeymap "n" "<a-k>" "<cmd>m .-2<cr>==" "Move line up")

    (mkKeymap "n" "<leader>qq" "<cmd>quitall!<cr>" "Quit!")
    (mkKeymap "n" "<leader>qw" "<cmd>:lua vim.cmd('close')<cr>" "Quit!")

    (mkKeymap "n" "<leader><leader>" "<cmd>nohl<cr>" "no highlight!")
    (mkKeymap "n" "<leader>A" "ggVG" "select All")

    (mkKeymap "n" "<leader>|" "<cmd>vsplit<cr>" "vertical split")
    (mkKeymap "n" "<leader>-" "<cmd>split<cr>" "horizontal split")

    (mkKeymap "n" "n" "nzzzv" "Move to center")
    (mkKeymap "n" "N" "Nzzzv" "Moving to center")
    (mkKeymap "n" "<leader>sC" (helpers.mkRaw # lua
      ''
        require('stay-centered').toggle
      ''
    ) "Toggle stay-centered.nvim")

    (mkKeymapWithOpts "n" "j"
      ''v:count || mode(1)[0:1] == "no" ? "j" : "gj"''
      "Move down"
      { expr = true; })
    (mkKeymapWithOpts "n" "k"
      ''v:count || mode(1)[0:1] == "no" ? "k" : "gk"''
      "Move up"
      { expr = true; })

  ];
in
{
  keymaps = insert ++ normal ++ v ++ xv;

  # This is list to present icon on which key
  wKeyList = [
    (wKeyObj [ "<leader>A" "" "" "true" ])
    (wKeyObj [ "<leader><leader>" "" "" "true" ])
    (wKeyObj [ "<leader>q" "" "quit/session" ])
    (wKeyObj [ "z" "" "fold" ])
    (wKeyObj [ "g" "" "goto" ])
    (wKeyObj [ "[" "" "next" ])
    (wKeyObj [ "]" "" "prev" ])
    (wKeyObj [ "<leader>u" "󰔎" "ui" ])
    (wKeyObj [ "<leader>|" "" "vsplit" ])
    (wKeyObj [ "<leader>-" "" "split" ])
  ];

  extraConfigLua = # lua
    ''

      -- Use black hole register for 'x', 'X', 'c', 'C'
      vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'X', '"_X', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'C', '"_C', { noremap = true, silent = true })

      -- Visual mode
      vim.api.nvim_set_keymap('v', 'x', '"_d', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', 'X', '"_d', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', 'C', '"_c', { noremap = true, silent = true })

      -- In visual mode, paste from the clipboard without overwriting it
      vim.api.nvim_set_keymap("v", "p", '"_dP', { noremap = true, silent = true })

      -- Only this hack works in command mode
      vim.cmd([[
        cnoremap <C-j> <C-n>
        cnoremap <C-k> <C-p>
      ]])
    '';
}
