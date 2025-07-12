ARG PYTHON_VERSION=3.13
ARG DEBIAN_VERSION=bookworm


FROM ghcr.io/astral-sh/uv:python${PYTHON_VERSION}-${DEBIAN_VERSION} AS uv_base


# 作業用ディレクトリ
ENV APP_HOME=/app
WORKDIR $APP_HOME

# uv でのリンクモードを指定する。
ENV UV_LINK_MODE=copy
COPY pyproject.toml uv.lock  ./


# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


FROM uv_base AS develop

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    # install npm for claude-code
    npm \
    # install dev tools
    vim gh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Docker using the docker official script
RUN curl -fsSL https://get.docker.com | sh

# Copy Docker startup script
COPY docker/start-docker.sh /usr/local/bin/start-docker.sh
RUN chmod +x /usr/local/bin/start-docker.sh

# Docker daemonを自動起動するためのentrypoint設定
ENTRYPOINT ["/usr/local/bin/start-docker.sh"]

# hadolint ignore=DL3016
RUN npm install -g @anthropic-ai/claude-code

# install AWS CLI v2 for aarch64
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# install AWS CLI v2 for x86_64
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
#     && unzip awscliv2.zip \
#     && ./aws/install \
#     && rm -rf awscliv2.zip aws

RUN uv sync --dev
