# Blokus

Terminal-based 4-player [Blokus](https://en.wikipedia.org/wiki/Blokus) board game written in OCaml. Built as a CS 3110 project.

## Prerequisites

- OCaml (with OCamlbuild)
- opam packages: `ounit2`, `ANSITerminal`, `yojson`

## Build & Run

All commands run from the `blokus/` directory:

```bash
make play    # compile and run the game
make build   # compile all modules
make test    # compile and run OUnit2 tests
```

## How to Play

Four players (Blue, Green, Red, Yellow) take turns placing polyomino pieces on a 20x20 board. Each player has 21 pieces ranging from 1 to 5 squares.

**Rules:**
- Your first piece must cover your assigned board corner
- Each subsequent piece must touch a diagonal corner of your own color
- Pieces may never share an edge with another piece of your own color
- Score = total unplaced squares (lower is better)

**Turn flow:**
1. Pick a piece by index number
2. Pick a rotation
3. Enter row and column to place

Type `quit` to exit.

## Project Structure

| File | Description |
|------|-------------|
| `player.ml` | Core game logic — pieces, players, board, placement validation |
| `game.ml` | Board and piece rendering with ANSITerminal colors |
| `main.ml` | Game loop and turn management |
| `command.ml` | User input parsing (`quit`, `continue`, piece number) |
| `test.ml` | OUnit2 test suite |
