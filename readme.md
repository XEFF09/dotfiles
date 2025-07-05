## Requirements (for other systems)

- homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)`
- git: `brew install git`

## Installation

```
 $ git clone https://github.com/XEFF09/dotfiles.git
 $ cd dotfiles
 $ make brew-all
 $ stow . //or// stow --abort .
```

## Post-Installation

- emmet-lsp: `npm i -g @olrtg/emmet-language-server`
- github-copilot connection by `:Copilot` along with authentication `:Copilot auth`
