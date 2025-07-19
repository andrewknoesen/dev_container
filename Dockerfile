FROM ubuntu:25.04

ENV PATH="/opt/venv/bin:/root/.cargo/bin:/root/.local/bin:${PATH}"

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm

# Copy git config
COPY .gitconfig /root/

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        gcc \
        make \
        ripgrep \
        gpg \
        openssh-client \
        zsh \
        curl \
        git \
        wget \
        tmux \
        sudo \
        software-properties-common \
        ca-certificates \
        ripgrep \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev \
        python3-setuptools \
        nodejs \
        npm \
        cargo \
        fzf \
        fd-find \
        bat \
        eza && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install thefuck
RUN python3 -m venv /opt/venv
# Lets wait for a fix. This doesn't support python3.13 atm
# RUN pip install thefuck
RUN pip install git+https://github.com/DL909/thefuck.git

# Install Oh My Zsh and plugins
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" -- \
-t robbyrussell \
-p git \
-p https://github.com/zsh-users/zsh-autosuggestions \
-p https://github.com/zsh-users/zsh-completions \
-p https://github.com/zsh-users/zsh-syntax-highlighting

ENV SHELL=/bin/zsh

# Zoxide
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# git-delta
ARG TARGETARCH
RUN case "${TARGETARCH:-amd64}" in \
      amd64) ARCH=amd64 ;; \
      arm64) ARCH=arm64 ;; \
      *) echo "Unsupported arch: $TARGETARCH" && exit 1 ;; \
    esac && \
    wget -O /tmp/git-delta.deb https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_${ARCH}.deb && \
    apt-get update && \
    apt-get install -y /tmp/git-delta.deb && \
    rm /tmp/git-delta.deb

# Neovim
# Neovim
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "arm64" ]; then \
        wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-arm64.tar.gz -O nvim.tar.gz; \
    else \
        wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.tar.gz -O nvim.tar.gz; \
    fi && \
    mkdir -p /opt/nvim && \
    tar xzf nvim.tar.gz -C /opt && \
    ln -s /opt/nvim-linux-$([ "$ARCH" = "arm64" ] && echo "arm64" || echo "x86_64")/bin/nvim /usr/local/bin/nvim && \
    rm nvim.tar.gz


# Create the local bin directory for the root user (default in Docker)
RUN mkdir -p /root/.local/bin

# Setup fd-find
# Create a symlink so you can use `fd` instead of `fdfind`
RUN ln -s $(which fdfind) /root/.local/bin/fd

# Setup bat
RUN ln -s /usr/bin/batcat ~/.local/bin/bat && \
    mkdir -p "$(bat --config-dir)/themes" && \
    curl -Lo "$(bat --config-dir)/themes/tokyonight_night.tmTheme" https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme && \
    bat cache --build

# Install Powerlevel10k theme
RUN cd ~/ && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install MesloLGS NF fonts required for Powerlevel10k
RUN mkdir -p ~/.fonts && cd ~/.fonts && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Setup fzf
RUN cd ~/ && git clone https://github.com/junegunn/fzf-git.sh.git

# TLDR
RUN cargo install tlrc --locked



# Copy files into root's home directory (adjust if using a non-root user)
COPY ./user_folder/ /root/

# COPY ./nvim/ ~/.config/nvim/

# Set working directory
WORKDIR /workdir

# Expose default shell
CMD ["zsh"]
