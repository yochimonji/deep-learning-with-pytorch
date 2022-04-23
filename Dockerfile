FROM nvidia/cuda:11.3.1-cudnn8-devel

# 環境変数
ENV PIPENV_VENV_IN_PROJECT=true
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# # 各種インストール
RUN apt update && \
    apt install -y --no-install-recommends \
    git \
    curl \
    python3.9 \
    python3.9-distutils

# Python環境設定
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.9 get-pip.py && \
    rm get-pip.py && \
    ln -s python3.9 python && \
    mv python /usr/bin/


# # 仮想環境構築
COPY Pipfile* ./
RUN pip install pipenv && \
    pipenv --python 3.9 && \
    pipenv sync --dev