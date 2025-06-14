{ pkgs, config, lib, ... }:
let inherit (config.nvix.mkKey) wKeyObj;
in {

  plugins = {
    lsp.servers.texlab.enable = true;
    vimtex = {
      enable = true;
      texlivePackage = pkgs.texlive.combined.scheme-full;
    };
  };

  extraPackages = [ pkgs.python313Packages.pylatexenc ];
  extraConfigLuaPre = ''
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = ".build" -- you can set here whatever name you desire
    }
    vim.g.vimtex_quickfix_ignore_filters = { 'warning' }
    vim.g.vimtex_quickfix_open_on_warning = 0
  '';

  globals.maplocalleader = " t"; # Set the local leader to "<leader>t"

  wKeyList = [
    (wKeyObj [ "<leader>t" "" "tex" ])
    (wKeyObj [ "<leader>tl" "" "vimtex" ])
  ];
  imports = with builtins; with lib;
    map
      (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));
}
