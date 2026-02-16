# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

All commands run from `blokus/` directory:

```bash
make play          # compile and run the game
make build         # compile all modules
make test          # run OUnit2 tests
make clean         # remove build artifacts
```

## Validation

Before committing, always run:

```bash
cd blokus/ && make build && make test
```

## Language & Dependencies

OCaml project using dune. Dependencies: `ounit2`, `ANSITerminal`.

## Architecture

**20x20 board game for 4 players** (Blue→Green→Red→Yellow), each placing polyomino pieces.

- **`player.ml`** — Core game logic. Defines pieces (21 polyominoes with rotation orientations), players, and the `char array array` gameboard. Contains all placement validation: corner-touching rules (`check_corners`), no face-touching (`check_faces`), empty-space checks (`can_place_piece`), and first-move corner placement (`starting_pos`).
- **`game.ml`** — Board and piece rendering via ANSITerminal colors.
- **`main.ml`** — Game loop and turn management. Handles piece selection → orientation selection → row/col input.
- **`command.ml`** — Parses user input: `quit`, `continue`, or piece number.

## Key Types (player.mli)

- `orientation` — piece shape as coordinate list + corner positions
- `piece` — color (`'R'|'G'|'B'|'Y'`), board position, list of orientations
- `player` — piece inventory, points, color
- `gameboard` — `char array array`
