#!/bin/sh
set -eu

detect_package_manager() {
    for pm in apt-get apk dnf yum; do
        if command -v $pm >/dev/null; then
            case $pm in
                apt-get) echo "apt" ;;
                *) echo "$pm" ;;
            esac
            return 0
        fi
    done
    echo "unknown"
    return 1
}

install_packages() {
    pkg_manager="$1"
    shift
    packages="$*"

    case "$pkg_manager" in
        apt)
            apt-get update
            apt-get install -y $packages
            ;;
        apk)
            apk add --no-cache $packages
            ;;
        dnf|yum)
            $pkg_manager install -y $packages
            ;;
        *)
            echo "WARNING: Unsupported package manager. Cannot install packages: $packages"
            return 1
            ;;
    esac
}

# Python package names vary slightly across distros.
ensure_python() {
    pkg_manager="$1"
    if command -v python3 >/dev/null && command -v pip3 >/dev/null; then
        return 0
    fi
    case "$pkg_manager" in
        apt)  install_packages apt python3 python3-pip ;;
        apk)  install_packages apk python3 py3-pip ;;
        dnf)  install_packages dnf python3 python3-pip ;;
        yum)  install_packages yum python3 python3-pip ;;
        *)
            echo "ERROR: Cannot install Python on unknown package manager"
            return 1
            ;;
    esac
}

pip_install_global() {
    # PEP 668 blocks system-wide pip on newer distros; --break-system-packages
    # is the documented escape hatch and is appropriate inside a container.
    if pip3 install --help 2>/dev/null | grep -q -- '--break-system-packages'; then
        pip3 install --no-cache-dir --break-system-packages "$@"
    else
        pip3 install --no-cache-dir "$@"
    fi
}

install_tflint() {
    echo "Installing tflint..."
    curl -fsSL https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
}

main() {
    echo "Activating feature 'pre-commit'"

    PKG_MANAGER=$(detect_package_manager)
    echo "Detected package manager: $PKG_MANAGER"

    MISSING_DEPS=""
    command -v curl >/dev/null || MISSING_DEPS="$MISSING_DEPS curl"
    command -v unzip >/dev/null || MISSING_DEPS="$MISSING_DEPS unzip"
    command -v git >/dev/null || MISSING_DEPS="$MISSING_DEPS git"
    if [ -n "$MISSING_DEPS" ]; then
        echo "Installing missing dependencies:$MISSING_DEPS"
        install_packages "$PKG_MANAGER" $MISSING_DEPS
    fi

    ensure_python "$PKG_MANAGER"

    echo "Installing pre-commit and checkov via pip..."
    pip_install_global pre-commit checkov

    install_tflint

    echo "Installed versions:"
    pre-commit --version
    checkov --version
    tflint --version
}

main
