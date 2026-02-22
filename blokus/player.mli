(** Color variant — replaces char-encoded 'R'/'G'/'B'/'Y' *)
type color = Blue | Green | Red | Yellow

type orientation = {
  coordinates : (int * int) list;
}

type piece = {
  color : color;
  shape : orientation list;
}

(** Board cell: None = empty, Some color = occupied *)
type cell = color option
type gameboard = cell array array

type player = {
  inventory : piece list;
  color : color;
}

val board_size : int

val char_of_color : color -> char
val color_of_char : char -> color option

val compute_corners : (int * int) list -> (int * int) list
val translate : (int * int) list -> int * int -> (int * int) list
val check_corners : color -> (int * int) list -> gameboard -> bool
val check_faces : color -> (int * int) list -> gameboard -> bool
val starting_pos : (int * int) list -> bool

val validate_placement :
  color -> (int * int) list -> gameboard -> int * int -> bool ->
  (int * int) list option

val placed_piece : piece -> player -> player

val player_red : player
val player_green : player
val player_blue : player
val player_yellow : player

val pieces : piece list
val set_color : color -> piece -> piece
val inventory_generator : color -> piece list

val adjust_playerlist : player list -> player -> player list
val get_next_player : player list -> player -> player
val remove_player : player list -> player -> player list
val find_player : player list -> player -> player list

val score : player -> int
