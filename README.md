# Blokus

4-player [Blokus](https://en.wikipedia.org/wiki/Blokus) board game written in OCaml, with both terminal and GUI (Bogue/SDL2) interfaces.

## Quick Start

```bash
cd blokus/
./setup.sh    # installs opam, OCaml, and dependencies
make play     # compile and run
```

## Manual Setup

If you prefer to install manually:

1. **Install opam** (OCaml package manager):
   - macOS: `brew install opam`
   - Ubuntu/Debian: `sudo apt-get install opam`
   - Other: [opam.ocaml.org/doc/Install](https://opam.ocaml.org/doc/Install.html)

2. **Initialize opam and install OCaml:**
   ```bash
   opam init -y
   eval $(opam env)
   ```

3. **Install dependencies:**
   ```bash
   opam install -y dune ounit2 ANSITerminal
   ```

4. **Install GUI dependencies (optional):**
   ```bash
   brew install sdl2 sdl2_image sdl2_ttf
   opam install bogue
   ```

5. **Build and run:**
   ```bash
   cd blokus/
   make play   # terminal UI
   make gui    # graphical UI
   ```

## Build Commands

All commands run from the `blokus/` directory:

```bash
make play    # compile and run the terminal game
make gui     # compile and run the GUI (Bogue/SDL2)
make build   # compile all modules
make test    # run OUnit2 test suite
make clean   # remove build artifacts
```

## How to Play

### Overview

Four players take turns placing polyomino pieces on a 20x20 board. Each player has 21 pieces ranging from 1 to 5 squares (1 monomino, 1 domino, 2 trominoes, 5 tetrominoes, 12 pentominoes).

**Turn order:** Blue, Green, Red, Yellow (repeating).

### Placement Rules

1. **First piece** must cover your assigned board corner
2. **Subsequent pieces** must diagonally touch at least one piece of your own color
3. **No edge-sharing** with your own color (diagonal only)
4. Pieces of **different colors** can share edges
5. All target cells must be **empty**

### On Your Turn

1. Pick a piece by its index number
2. Pick a rotation/orientation
3. Enter the row and column to place it

Type `quit` to exit the game.

### Scoring

Score = total squares across your unplaced pieces. **Lowest score wins** (place as many squares as possible).

## Project Structure

| File | Description |
|------|-------------|
| `player.ml` | Core game logic — pieces, players, board, placement validation |
| `game.ml` | Board and piece rendering with ANSITerminal colors |
| `main.ml` | Game loop and turn management |
| `command.ml` | User input parsing (`quit`, `continue`, piece number) |
| `gui_main.ml` | GUI entry point — Bogue/SDL2 graphical interface |
| `gui_state.ml` | GUI game state and pure transitions |
| `test.ml` | OUnit2 test suite |
