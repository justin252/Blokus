type orientation = {
  coordinates : (int * int) list;
}

type piece = {
  color : char;
  shape : orientation list;
}

type gameboard = char array array

type player = {
  inventory : piece list;
  color : char;
}

val board_size : int

val compute_corners : (int * int) list -> (int * int) list

val translate : (int * int) list -> int * int -> (int * int) list

val check_corners : char -> (int * int) list -> gameboard -> bool

val check_faces : char -> (int * int) list -> gameboard -> bool

val starting_pos : (int * int) list -> bool

val validate_placement :
  char -> (int * int) list -> gameboard -> int * int -> bool ->
  (int * int) list option

val placed_piece : piece -> player -> player

val player_red : player
val player_green : player
val player_blue : player
val player_yellow : player

val pieces : piece list
val set_color : char -> piece -> piece
val inventory_generator : char -> piece list

val adjust_playerlist : player list -> player -> player list
val get_next_player : player list -> player -> player
val remove_player : player list -> player -> player list
val add_player : player list -> player -> player list

val score : player -> int
