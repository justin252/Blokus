type orientation={
  coordinates: (int * int) list;
  corners: (int * int) list;
}

type piece = {
  color : char;
  mutable position_on_board: (int*int) list;
  mutable position_on_board_corners: (int*int) list;
  shape : orientation list;
}

type gameboard = char array array

type player={
  inventory: piece list; 
<<<<<<< HEAD:blokus/player.mli
  points : int;
=======
  mutable points : int;
>>>>>>> Nas:blokus/blokus/player.mli
  color: char;
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
(*val is_eliminated : piece -> bool*)

val check_corners: piece -> gameboard -> bool 

val check_faces: piece -> gameboard -> bool

val place_piece: (int * int) list -> int * int -> (int * int) list

val is_valid: 
  piece -> 
  (int * int) list -> (int * int) list -> gameboard -> int * int -> bool

val player_red: player

val player_green: player

val player_blue: player

val player_yellow: player

<<<<<<< HEAD:blokus/player.mli
val check_corners: piece -> gameboard -> bool 

val check_faces: piece -> gameboard -> bool

=======
val actually_place_piece: piece -> gameboard -> unit

val adjust_playerlist: player list -> player -> player list

val get_next_player: player list -> player -> player

val remove_player: player list -> player -> player list

val can_place_piece: piece -> char array array -> bool

(*val update_pos_on_board: piece -> (int * int) list -> int * int -> unit*)

(*val update_corn_on_board: piece -> (int * int) list -> int * int -> unit*)
>>>>>>> Nas:blokus/blokus/player.mli

(*
(** [is_touching player game] sees that the placed piece touches just the 
    corner of one of the pieces on the board and does not touch the faces 
    of it’s other pieces. *)
(*val is_touching : piece -> (int * int) -> game -> bool*)
val get_all_corners: bool array array -> (int*int) list
 *)

(* val is_touching_simple: int * int -> game -> bool *)

(*type player_piece
  type game_board
  val is_touching: (int * int) -> player_piece -> game_board -> bool
<<<<<<< HEAD:blokus/player.mli

  val valid_moves: (int * int) -> player_piece -> game_board -> (int * int) list
=======
  val valid_moves: (int * int) -> player_piece -> game_board -> (int * int) list*)
>>>>>>> Nas:blokus/blokus/player.mli
