# Functional Refactoring Report — Blokus

This document explains the functional programming principles applied during the refactoring of the Blokus OCaml codebase, why each matters, and where imperative style was deliberately retained.

## 1. Sum Types over Primitive Encoding

**Before:** Colors encoded as `char` — `'R'`, `'G'`, `'B'`, `'Y'`. Any char could flow through the system; a typo like `'r'` would silently produce wrong behavior.

**After:** `type color = Blue | Green | Red | Yellow`. The compiler enforces exhaustive matching — every `match` on color must handle all four variants or the compiler warns. Adding a fifth color would trigger errors at every unhandled site, making extension safe.

**Key insight:** Sum types turn runtime bugs into compile-time errors. When the domain has a fixed set of values, encoding them as variants lets the compiler verify completeness.

## 2. Higher-Order Functions over Manual Recursion

**Before:** Functions like `placed_piece_helper`, `adjust_playerlist`, `remove_player`, `print_pieces`, and `print_scores` all used hand-written `match h :: t` recursion — the same structural pattern repeated with slight variations.

**After:** Each replaced with the appropriate stdlib combinator:
- `List.fold_left` for accumulation (removing first matching piece)
- `List.map` for element-wise transformation (updating a player in a list)
- `List.filter` for selection (removing a player)
- `List.iteri` for indexed iteration (printing pieces with numbers)
- `List.iter` for simple traversal (printing scores)
- `List.find` / `List.find_opt` for search (finding a player, next player index)

**Key insight:** Higher-order functions communicate *intent*. `List.filter` immediately tells the reader "we're keeping elements that match a predicate." Manual recursion forces the reader to mentally simulate the recursion to understand the same thing.

## 3. Pattern Matching over If/Else Chains

**Before:** `game.ml` had 4-deep `if/else if` chains to select ANSITerminal colors based on char values. `match_color` used the same pattern. `command.ml` used `if h = "quit" then ... else if parse_int str = -1 then ...`.

**After:** Pattern matching on the `color` variant is exhaustive and flat:
```ocaml
let ansi_style_of_color = function
  | Blue -> ANSITerminal.[blue]
  | Green -> ANSITerminal.[green]
  | Red -> ANSITerminal.[red]
  | Yellow -> ANSITerminal.[yellow]
```

The compiler ensures every case is covered. No `else failwith "impossible"` needed.

## 4. Option/Result over Exceptions

**Before:** `command.ml` used `exception Empty` and `exception Malformed`. Callers caught these with `match parse str with exception Empty -> ...`. `parse_int` returned `-1` as a sentinel for failure.

**After:** `parse` returns `parse_result = Ok of command | Empty_input | Bad_input`. `parse_int` returns `int option`. No exceptions, no sentinels. The type signature tells callers exactly what outcomes to handle — the compiler enforces it.

**Key insight:** Exceptions are invisible in type signatures. A function `string -> command` that raises looks identical to one that doesn't. `string -> parse_result` makes failure explicit and pattern-matchable.

## 5. Pipe Operator for Data Flow

**Before:** Nested function calls like `snd (List.fold_left ... (false, []) player.inventory)` required reading inside-out.

**After:** Pipes read left-to-right, matching the data flow:
```ocaml
player.inventory
|> List.fold_left (fun (found, acc) p -> ...) (false, [])
|> snd |> List.rev
```

Also used in `score`, `parse`, and `compute_corners` (via `List.concat_map`).

## 6. Immutable State Records over Loose Parameters

**Before:** `play_game_helper` threaded 5 separate parameters: `playerlist`, `board`, `currplayer`, `player_scores`, `is_first`. Every recursive call repeated all 5.

**After:** A single `game_state` record groups them. Functional record update `{ st with board = newboard; ... }` makes transitions clear — you see exactly which fields change.

**Key insight:** Records make state transitions explicit. `{ st with is_first = false }` documents that only `is_first` changed. With loose parameters, you'd need to compare all 5 arguments between caller and callee to see what changed.

## 7. Copy-on-Write over Mutation

**Before:** `update_board` and `gui_state.place` mutated the board array in-place with `board.(x).(y) <- color`.

**After:** `Array.init` + `Array.copy` creates a new board with changes applied:
```ocaml
Array.init (Array.length board) (fun r ->
  let row = Array.copy board.(r) in
  List.iter (fun (pr, pc) -> if pr = r then row.(pc) <- Some color) cells;
  row)
```

The original board is untouched. This enables safe undo, history, or parallel evaluation.

## 8. What Stayed Imperative and Why

**GUI global refs:** `gui_main.ml` keeps `state` and `hover_cell` as `ref` values. Bogue's callback model (`W.connect_main`) requires mutable state — callbacks are `unit -> unit` with no way to thread state through the event loop. This is a pragmatic boundary: the functional core computes new states, and the imperative shell applies them.

**Array board representation:** The gameboard remains `color option array array` rather than a purely functional structure (e.g., `Map`). Arrays give O(1) cell access, which matters for the 20×20 board checked on every placement. The copy-on-write pattern gives us immutability semantics while keeping array performance.

**I/O in main.ml:** `read_line`, `print_endline`, etc. are inherently effectful. The refactoring pushed effects to the boundary (the game loop) while keeping game logic (validation, scoring, player management) pure.
