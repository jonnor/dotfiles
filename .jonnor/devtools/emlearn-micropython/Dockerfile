FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    pkg-config \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Setup MicoPython
RUN git clone https://github.com/micropython/micropython.git && \
    cd micropython && \
    make -C mpy-cross && \
    make -C ports/unix submodules && \
    make -C ports/unix && \
    cp ports/unix/build-standard/micropython /usr/bin/micropython

# Setup Python dependencies
COPY requirements.txt requirements.dev.txt .
RUN pip3 install --break-system-packages -r requirements.txt -r requirements.dev.txt

# Setup ARM toolchain and qemu
RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi binutils-arm-none-eabi qemu-system-arm \
    && rm -rf /var/lib/apt/lists/*

# Setup tmux and pi coding agent
# needs ripgrep and fd
RUN apt-get update && apt-get install -y \
    tmux \
    curl \
    ripgrep \
    fd-find \
    && rm -rf /var/lib/apt/lists/*

# expose fd as "fd"
RUN ln -s $(which fdfind) /usr/local/bin/fd

# Need recent Nodejs for pi
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @mariozechner/pi-coding-agent

# Expected to be mounted
WORKDIR /workspace

CMD ["tmux"]
