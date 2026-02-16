#!/bin/bash
set -e

# Install opam if missing
if ! command -v opam &> /dev/null; then
  echo "Installing opam..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install opam
  else
    sudo apt-get update && sudo apt-get install -y opam
  fi
fi

# Initialize opam if needed
if [ ! -d "$HOME/.opam" ]; then
  opam init -y --bare
  opam switch create default 5.2.1
fi

eval $(opam env)

# Install dependencies
opam install -y dune ounit2 ANSITerminal

echo "Setup complete. Run 'make play' to start."
