open Player

val print_board: gameboard -> unit

val print_pieces: Player.player -> unit

val print_orientation: Player.piece -> unit

val player_list: player list

val update_board: Player.player -> (int * int) list -> char array array -> char array array