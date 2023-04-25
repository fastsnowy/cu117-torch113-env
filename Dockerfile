FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04
WORKDIR /workspace
ARG DOCKER_UID=1000
ARG DOCKER_USER=devuser
ARG DOCKER_PASSWORD=docker
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    sudo \
    build-essential \
    tzdata \
    git \
    vim \
    wget \
    zsh \
    curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    xz-utils \
    zlib1g-dev \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.8 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip
# add asdf install
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
SHELL ["/bin/bash", "-c"]
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc \
&& echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc \
&& echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc \
&& echo -e '\nfpath=(${ASDF_DIR}/completions $fpath)\nautoload -Uz compinit && compinit' >> ~/.zshrc

CMD ["/bin/bash"]
