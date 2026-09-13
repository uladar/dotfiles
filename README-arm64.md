# Apple Silicon setup

This checkout is separate from the Intel configuration in `~/.dotfiles`.
The Apple Silicon setup uses Neovim as the only active editor configuration;
the legacy `vimrc` is intentionally not installed.

Install the native tools on the new Mac:

```sh
brew bundle --file="$HOME/.dotfiles_arm64/Brewfile"
```

Install Alacritty from the official signed DMG because the Homebrew cask is
currently disabled by Gatekeeper:

https://github.com/alacritty/alacritty/releases

Install ChromeDriver separately only if browser tests require it. The
Homebrew cask is currently disabled by Gatekeeper; Chrome for Testing also
provides matching driver downloads:

https://googlechromelabs.github.io/chrome-for-testing/

Install TPM for the tmux plugins:

```sh
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
```

Preview the files that `rcup` will manage:

```sh
lsrc -d "$HOME/.dotfiles_arm64"
```

Apply them only on the Apple Silicon Mac:

```sh
env RCRC="$HOME/.dotfiles_arm64/rcrc" rcup -d "$HOME/.dotfiles_arm64" -v
```

Link the VS Code settings into the macOS-specific user directory:

```sh
mkdir -p "$HOME/Library/Application Support/Code/User"
ln -sfn "$HOME/.dotfiles_arm64/config/vscode/settings.json" \
  "$HOME/Library/Application Support/Code/User/settings.json"
```

Install the curated VS Code extensions:

```sh
grep -vE '^[[:space:]]*(#|$)' "$HOME/.dotfiles_arm64/config/vscode/extensions.txt" \
  | xargs -n 1 code --install-extension
```

Reload tmux and install the configured plugins with `Ctrl-a`, then `Shift-i`:

```sh
tmux source-file "$HOME/.tmux.conf"
```

After the first apply, `rcup` can be run normally. `mise` reads the existing
`.ruby-version`, `.node-version`, `.nvmrc` and `.tool-versions` files in each
project. Install a project's declared runtimes with:

```sh
mise install
```

Docker Desktop is installed by the Brewfile. Keep it stopped when it is not
needed and start only the project services required by the current project.

`rmpc` is installed alongside `ncmpcpp` as a modern MPD client alternative.
Both use the same MPD server and can be compared without changing the music
library.
