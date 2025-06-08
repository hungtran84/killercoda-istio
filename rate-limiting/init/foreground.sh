#!/bin/bash
# shellcheck source=/dev/null

FILE=/ks/wait-background.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done;
bash ${FILE}

# Install Istio
export ISTIO_VERSION=1.24.6
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$ISTIO_VERSION TARGET_ARCH=x86_64 sh -

# Rename Istio directory for consistency
mv istio-${ISTIO_VERSION} istio

# Set PATH in .bashrc because no subshell can set parent environment variables
echo "export PATH=~/istio/bin:\$PATH" >> ~/.bashrc
export PATH=~/istio/bin:$PATH

# Istio autocomplete
echo "[[ -r \"/usr/local/etc/profile.d/bash_completion.sh\" ]] && . \"/usr/local/etc/profile.d/bash_completion.sh\"" >> ~/.bash_profile
cp istio/tools/istioctl.bash ./istioctl.bash
echo "source ~/istioctl.bash" >> ~/.bashrc

# Kubectl alias
echo "alias k='kubectl'" >> ~/.bashrc

source "${HOME}/.bashrc"

# Deploy Istio with demo profile
mv /tmp/demo.yaml istio/manifests/profiles/
istioctl install --set profile=demo -y --manifests=istio/manifests

clear
echo "Scenario is ready" 