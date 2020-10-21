(** 
   Representation of static game data.

   This module represents the data stored in the game. It handles all the 
   ........
*)

(** The abstract type of values representing game. *)
type t

type state
(* I was thinking we could do states as "over" "1 player remaining" 
   "two players remaining" "three players remaining" "4 players remaining"*)


(** [game_state game] is the state of the game 
    Requires: [game] is a valid game representation. *)
val game_state : t -> state

(** [placed_piece p] removes the piece that [p] represents.
    Requires: [p] is a valid player piece representation. *)
val whose_turns : piece -> game -> game

(** [valid_moves v] is set of valid moves for a piece after a piece has 
    been chosen by the player for each orientation possible
    Requires: [p] is a valid player piece representation. *)
val change_turns : piece -> piece array

(** [is_eliminated player] sees all the valid moves remaining for the 
    remaining pieces. 
    Returns: true if nothing and false if there are still moves.  *)
val is_eliminated : t -> bool

(** [is_touching player game] sees that the placed piece touches just the 
    corner of one of the pieces on the board and does not touch the faces 
    of it’s other pieces. *)
val is_touching : t -> game -> bool

(** [score t] is the score of the player.
*)
val score : t -> int

(** do we need a function that updates the score after every round? *)