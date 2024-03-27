_: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "tomorrow-night";
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}
