ARG UBUNTU_VERSION="22.04"

FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-${UBUNTU_VERSION}

ARG UBUNTU_CODENAME="jammy"
ARG ANSIBLE_LINT_VERSION

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
  && set -x \
  && mkdir -p /etc/apt/keyrings \
  && wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmor -o /etc/apt/keyrings/ansible-archive-keyring.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu ${UBUNTU_CODENAME} main" | tee /etc/apt/sources.list.d/ansible.list \
  && apt update \
  && apt install --no-install-recommends --yes \
    ansible \
    ca-certificates \
    iputils-ping \
    python3 \
    python3-dev \
    python3-passlib \
    python3-pip \
    vim \
  && apt autoremove --yes \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
  && pip3 install "ansible-lint==${ANSIBLE_LINT_VERSION}"

USER vscode

ARG AGE_VERSION
ARG AWSCLI_VERSION
ARG HELM_VERSION
ARG HELMFILE_VERSION
ARG KREW_VERSION
ARG KUBECTL_VERSION
ARG SOPS_VERSION
ARG TERRAFORM_VERSION
ARG TFLINT_VERSION

ENV PATH=${PATH}:${HOME}/.local/bin

COPY library-scripts/genSSC.sh ${HOME}/.local/bin/genSSC.sh
COPY library-scripts/install-tools.sh /tmp/

RUN mkdir -p "${HOME}/.local/bin" \
  && /tmp/install-tools.sh \
  && sudo rm -f /tmp/install-tools.sh
