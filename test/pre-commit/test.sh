#!/bin/bash

set -e

source dev-container-features-test-lib

check "pre-commit installed" command -v pre-commit
check "pre-commit version" pre-commit --version
check "checkov installed" command -v checkov
check "checkov version" checkov --version
check "tflint installed" command -v tflint
check "tflint version" tflint --version

reportResults
