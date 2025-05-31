{
  plugins.dashboard = {
    enable = true;
    settings = {
      change_to_vcs_root = true;
      config = {
        packages.enable = false;
        footer = [
          ""
          "From niksingh710"
          ""
        ];
        mru.limit = 5;
        week_header.enable = true;
        project.enable = false;
        shortcut = [
          {
            action = "Telescope find_files";
            desc = "Files";
            group = "Label";
            icon = " ";
            icon_hl = "@variable";
            key = "f";
          }
          {
            action = "SessionRestore";
            desc = "󰝳 Session";
            group = "Number";
            key = ".";
          }
          {
            action = "Telescope oldfiles";
            desc = "󱦠 Recent Files";
            group = "DiagnosticHint";
            key = "a";
          }
          {
            action = "quitall!";
            desc = "󰈆 Quit";
            group = "DiagnosticError";
            key = "q";
          }
        ];
      };
      theme = "hyper";
    };
  };

}
