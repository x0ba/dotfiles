if [ -x "$(command -v lsd)" ]; then
  # add a bit more space between the file icon & name
  alias ls='eza'
  alias l='eza'
  alias ll='eza -l'
  alias la='eza -la'
  alias tree='eza --tree'
else
  alias l='ls'
  alias ll='ls -l'
  alias la='ls -lA'
fi
