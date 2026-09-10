# Add Docker Desktop commands to PATH when Docker Desktop is installed.
if [[ -d "$HOME/.docker/bin" ]]; then
  export PATH="$PATH:$HOME/.docker/bin"
fi
