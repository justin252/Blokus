

(** The type of player's piece. *)
type piece = {
  color : string;
  shape : (int * int) list;
}

(** The abstract type of values representing player. *)
type player={
  inventory: piece list; 
  points : int;
  color: string;
}

(** The type of game board. *)
type game = {
  gameboard: char array array
}

(** [placed_piece p] removes the piece that [p] represents.
    Requires: [p] is a valid player piece representation present in 
    the player's inventory. *)
val placed_piece : piece -> player -> player

(** [valid_moves v] is set of valid moves for a piece after a piece has 
    been chosen by the player for each orientation possible
    Requires: [p] is a valid player piece representation. *)
(*val valid_moves : piece -> (int * int) -> game -> (int * int ) list*)

(** [is_eliminated player] sees all the valid moves remaining for the 
    remaining pieces. 
    Returns: true if nothing and false if there are still moves.  *)
val is_eliminated : piece -> bool

(** [is_touching player game] sees that the placed piece touches just the 
    corner of one of the pieces on the board and does not touch the faces 
    of it’s other pieces. *)
(*val is_touching : piece -> (int * int) -> game -> bool*)

val get_all_corners: bool array array -> (int*int) list

val is_touching_simple: int * int -> game -> bool

(*type player_piece

  type game_board

  val is_touching: (int * int) -> player_piece -> game_board -> bool

  val valid_moves: (int * int) -> player_piece -> game_board -> (int * int) list*)
