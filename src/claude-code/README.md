
# Claude Code CLI (claude-code)

Installs the Claude Code CLI globally

## Example Usage

```json
"features": {
    "ghcr.io/PhilAtVisir/devcontainer-features/claude-code:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## Customizations

### VS Code Extensions

- `anthropic.claude-code`

# Using Claude Code in devcontainers

## Installation

This feature installs Claude Code using the [native installer](https://claude.ai/install.sh). No additional features or dependencies need to be added to your devcontainer configuration.

```json
"features": {
    "ghcr.io/anthropics/devcontainer-features/claude-code:1": {}
}
```

## Alpine Linux

On Alpine-based containers, this feature automatically installs the required additional dependencies: `libgcc`, `libstdc++`, and `ripgrep`.

## Deprecation notice

The previous NPM-based installation method (`npm install -g @anthropic-ai/claude-code`) has been deprecated. This feature now uses the native installer. For more information, see the [official documentation](https://code.claude.com/docs/en/getting-started#npm-installation-deprecated).

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/PhilAtVisir/devcontainer-features/blob/main/src/claude-code/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
