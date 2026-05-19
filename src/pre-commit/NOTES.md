# pre-commit feature

Installs:

- [`pre-commit`](https://pre-commit.com/) — via `pip`
- [`checkov`](https://www.checkov.io/) — via `pip`
- [`tflint`](https://github.com/terraform-linters/tflint) — via the upstream `install_linux.sh` script

Python and `pip` are installed automatically if not already present (supported on Debian/Ubuntu, Alpine, Fedora, and RHEL/CentOS).

On distros that enforce PEP 668 (Debian 12+, Ubuntu 24.04+), the pip installs use `--break-system-packages`, which is appropriate inside a container.
