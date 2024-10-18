#!/usr/bin/env nu

$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir ~/.cache/carapace
carapace _carapace nushell | save -f ~/.cache/carapace/init.nu

$env.NPM_CONFIG_PREFIX = "~/.local"
$env.NPM_PACKAGES = "~/.npm-packages"
$env.PATH = ($env.PATH | append '~/.cargo/bin' | append '~/.local/bin' | append $'($env.NPM_PACKAGES)/bin')

$env.GPG_TTY = (tty)
$env.SSH_AUTH_SOCK = (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

