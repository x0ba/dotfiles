FROM opensuse/tumbleweed:latest

RUN zypper --non-interactive in \
  ccache \
  starship \
  zellij \
  fd \
  ripgrep \
  gcc \
  git \
  sudo \
  atuin \
  bat \
  fzf \
  direnv \
  eza \
  neovim \
  nodejs \
  npm \
  python \
  yazi \
  ripgrep \
  unzip \
  zip \
  zoxide \
  zsh

# initialize the demo user
RUN useradd -m demo && \
  echo "demo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER demo
WORKDIR /home/demo


ENV PATH="/home/demo/.local/bin:${PATH}"
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

# copy the dotfiles
COPY --chown=demo:demo . /home/demo/.local/share/chezmoi
# make sure the ownership is correct
RUN sudo chown -R demo:demo /home/demo/.local

# install them
RUN chezmoi init && chezmoi apply

# set up zinit
RUN zsh -c "zsh ~/.config/zsh/.zshrc; exit 0"

# set up neovim, cloning lazy.nvim and installing plugins
RUN git clone --filter=blob:none --single-branch \
  https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
RUN nvim --headless "+Lazy! sync" +qa

# use zsh as the default shell
ENTRYPOINT ["/bin/zsh"]

