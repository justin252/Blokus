# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

All commands run from `blokus/` directory:

```bash
make play          # compile and run the terminal game
make gui           # compile and run the GUI (Bogue/SDL2)
make build         # compile all modules
make test          # run OUnit2 tests
make clean         # remove build artifacts
```

GUI dev workflow: `cd blokus/ && dune exec --watch ./gui_main.exe` — auto-recompiles on save.

## Validation

Before committing, always run:

```bash
cd blokus/ && make build && make test
```

Update README.md and CLAUDE.md when changes affect build commands, dependencies, project structure, or new entry points.

## Language & Dependencies

OCaml project using dune. Dependencies: `ounit2`, `ANSITerminal`, `bogue` (GUI).

GUI requires SDL2: `brew install sdl2 sdl2_image sdl2_ttf && opam install bogue`.

## Architecture

**20x20 board game for 4 players** (Blue→Green→Red→Yellow), each placing polyomino pieces.

- **`player.ml`** — Core game logic. Defines pieces (21 polyominoes with rotation orientations), players, and the `char array array` gameboard. Contains all placement validation: corner-touching rules (`check_corners`), no face-touching (`check_faces`), empty-space checks (`can_place_piece`), and first-move corner placement (`starting_pos`).
- **`game.ml`** — Board and piece rendering via ANSITerminal colors.
- **`main.ml`** — Game loop and turn management. Handles piece selection → orientation selection → row/col input.
- **`command.ml`** — Parses user input: `quit`, `continue`, or piece number.
- **`gui_main.ml`** — GUI entry point using Bogue/SDL2. Renders clickable 20x20 board. Independent from terminal UI (`game.ml`/`main.ml`).

## Key Types (player.mli)

- `orientation` — piece shape as coordinate list + corner positions
- `piece` — color (`'R'|'G'|'B'|'Y'`), board position, list of orientations
- `player` — piece inventory, points, color
- `gameboard` — `char array array`
