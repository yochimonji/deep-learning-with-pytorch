FROM nvidia/cuda:11.3.1-cudnn8-devel

# 環境変数
ENV HOME=/root
ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH=$PYENV_ROOT/bin:$PATH
ENV PATH=$PYENV_ROOT/shims:$PATH
ENV PIPENV_VENV_IN_PROJECT=true
ENV LC_CTYPE=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_VERSION=3.9.12

# 各種インストールとpyenv初期化
RUN apt update && \
    apt install -y --no-install-recommends \
    git \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev && \
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    echo 'eval "$(pyenv init --path)"' >> ~/.profile && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# 仮想環境構築
COPY Pipfile* ./
RUN pyenv install $PYTHON_VERSION && \
    pyenv global $PYTHON_VERSION && \
    pip install pipenv && \
    pipenv --python $PYTHON_VERSION && \
    pipenv sync --dev