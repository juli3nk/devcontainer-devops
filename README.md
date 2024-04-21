# Project Standardization Skeleton

The purpose of this skeleton is to establish a consistent version of tools for server configurations, whether for a standalone instance or a managed Kubernetes cluster.

Depending on the environment created, select the necessary components and adjusts the configurations accordingly.

## DevContainer configurations

* Pull or build container image.
* List of local directories that will be mounted in the dev container.
* Enable VSCode extensions depending of tools used.

ms-vscode-remote.remote-containers

### Build image locally

Instead of using the built image, it can be built locally and the devcontainer configuration file (`.devcontainer/devcontainer.json`) needs to be modified to replace the key `image` with the code below:

```json
  "build": {
    "dockerfile": "Dockerfile",
    "context": ".",
    "args": {
      "UBUNTU_VERSION": "22.04",
      "UBUNTU_CODENAME": "jammy",
      "AGE_VERSION": "1.1.1",
      "ANSIBLE_LINT_VERSION": "6.22.1",
      "AWSCLI_VERSION": "2.13.37",
      "HELM_VERSION": "3.13.2",
      "HELMFILE_VERSION": "0.159.0",
      "KREW_VERSION": "0.4.4",
      "KUBECTL_VERSION": "1.28.4",
      "SOPS_VERSION": "3.8.1",
      "TERRAFORM_VERSION": "1.6.6",
      "TFLINT_VERSION": "0.49.0"
    }
  },
```

### Mounted directories

* /var/run/docker.sock
* ${HOME}/.config/git
* ${HOME}/.ssh
* ${HOME}/.kube
* ${HOME}/.sops
* ${HOME}/.aws

### VSCode extensions

## Getting Started

When opening the project in VSCode, you will be prompted to open it in a container based on the configuration file `.devcontainer/devcontainer.json`.

To initialize the project after it's opened in a container, there are several tasks that need to be executed. These tasks are predefined in the file `.vscode/tasks.json`. To run them, navigate to `Terminal > Run Task...` in the menu, and then select the appropriate tasks.
