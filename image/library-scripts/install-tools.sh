#!/usr/bin/env bash

get_latest_tag() {
  local repo_url="$1"

  git ls-remote --tags "https://${repo_url}.git" | grep -v "{}" | awk -F'/' '{ print $3 }' | sort -V | tail -n 1
}


# Install asdf and plugins
ASDF_DIR_PATH="${HOME}/.asdf"
ASDF_VERSION="$(get_latest_tag github.com/asdf-vm/asdf)"

if [ ! -d "$ASDF_DIR_PATH" ]; then
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR_PATH" --branch "$ASDF_VERSION"
fi

. "${HOME}/.asdf/asdf.sh"

echo -e ". \"\${HOME}/.asdf/asdf.sh\"\n. \"\${HOME}/.asdf/completions/asdf.bash\"" >> "${HOME}/.bashrc"

declare -a apps=(
  "age:${AGE_VERSION:-latest}"
  "awscli:${AWSCLI_VERSION:-latest}"
  "helm:${HELM_VERSION:-latest}"
  "helmfile:${HELMFILE_VERSION:-latest}"
  "jq:${JQ_VERSION:-latest}"
  "krew:${KREW_VERSION:-latest}"
  "kubectl:${KUBECTL_VERSION:-latest}"
  "neovim:${NEOVIM_VERSION:-latest}"
  "sops:${SOPS_VERSION:-latest}"
  "terraform:${TERRAFORM_VERSION:-latest}"
  "tflint:${TFLINT_VERSION:-latest}"
  "yq:${YQ_VERSION:-latest}"
)

for app in "${apps[@]}"; do
  app_name="$(echo "$app" | awk -F':' '{ print $1 }')"
  app_version="$(echo "$app" | awk -F':' '{ print $2 }')"

  asdf plugin add "$app_name"
  asdf install "$app_name" "$app_version"
  asdf global "$app_name" "$app_version"
done

# Install helm plugins
declare -a helm_plugins=(
  "https://github.com/databus23/helm-diff"
  "https://github.com/jkroepke/helm-secrets"
)

for plugin in "${helm_plugins[@]}"; do
  helm plugin install "$plugin"
done
