_: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "one_dark";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}
