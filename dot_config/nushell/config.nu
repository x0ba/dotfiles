#!/usr/bin/env nu

$env.config = {
  show_banner: false
  rm: {
    always_trash: true
  }
  cursor_shape: {
    vi_insert: underscore
    vi_normal: block
    emacs: line
  }
  table: {
    mode: compact
    index_mode: auto
  }
  history: {
    max_size: 10_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: false
  }
  footer_mode: "auto"
  shell_integration: {
      osc2: true
      osc7: true
      osc8: true
      osc9_9: false
      osc133: true
      osc633: true
      reset_application_mode: true
  }
  use_kitty_protocol: true
  keybindings: [
    {
      name: delete_word
      modifier: control
      keycode: char_h # TODO: ctrl+backspace triggers `h`, this is a crossterm bug: https://github.com/crossterm-rs/crossterm/issues/685
      mode: emacs
      event: {
        until: [
          { edit: BackspaceWord }
        ]
      }
    }
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
  ]
}

alias cm = chezmoi
alias cma = chezmoi add
alias cmap = chezmoi apply
alias cmd = chezmoi diff
alias cme = chezmoi edit
alias cmm = chezmoi merge
alias cmrm = chezmoi remove
alias cmst = chezmoi status
alias cmup = chezmoi update
alias vim = nvim
alias c = clear

source ~/.cache/carapace/init.nu
source ~/.local/share/atuin/init.nu
source ~/.local/share/zoxide/init.nu
use ~/.cache/starship/init.nu

