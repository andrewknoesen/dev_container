FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
        nodejs \
        npm \
        fzf \
        fd-find \
        bat \
        eza && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy git config
COPY .gitconfig /root/

# Create the local bin directory for the root user (default in Docker)
RUN mkdir -p /root/.local/bin

# Add ~/.local/bin to PATH for all sessions
ENV PATH="/root/.local/bin:${PATH}"
    
# Setup fd-find
# Create a symlink so you can use `fd` instead of `fdfind`
RUN ln -s $(which fdfind) /root/.local/bin/fd

# Setup bat
RUN ln -s /usr/bin/batcat ~/.local/bin/bat && \
    mkdir -p "$(bat --config-dir)/themes" && \
    curl -Lo "$(bat --config-dir)/themes/tokyonight_night.tmTheme" https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme && \
    bat cache --build

# Install Oh My Zsh and plugins
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

# Install Powerlevel10k theme
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install MesloLGS NF fonts required for Powerlevel10k
RUN mkdir -p ~/.fonts && cd ~/.fonts && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf && \
    curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Setup fzf
RUN git clone https://github.com/junegunn/fzf-git.sh.git

# Set working directory
WORKDIR /workdir

# Copy files into root's home directory (adjust if using a non-root user)
COPY ./user_folder/ /root/

# Expose default shell
CMD ["zsh"]
