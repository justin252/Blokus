open Player

val print_board : gameboard -> unit

val print_pieces : player -> unit

val print_orientation : piece -> unit

val player_list : player list

val update_board : player -> (int * int) list -> gameboard -> gameboard

val print_scores : player list -> unit
