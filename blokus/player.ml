type game = string array array

type orientation={
  coordinates: (int * int) list;
  corners: (int * int) list;
}

type piece = {
  color : string;
  position_on_board: (int*int) list;
  position_on_board_corners: (int*int) list;
  shape : orientation list;
}

type player={
  inventory: piece list; 
  points : int;
  color: string;
}

let monomino_piece = [(1,1)]
let monomino_piece_corner = [(1,1)]

let domino_piece_orientation1 = [(1,1); (2,1)]
let domino_piece_orientation1_corner = [(1,1); (2,1)]
let domino_piece_orientation2 = [(1,1); (1,2)]
let domino_piece_orientation2_corner = [(1,1); (1,2)]

(* 
    x x
    x 

    x x
      x

      x
    x x

    x 
    x x

     *)

let tromino_piece1_orientation1 = [(1,1); (1,2); (2,1)]
let tromino_piece1_orientation1_corners = [(1,1); (1,2); (2,1)]
let tromino_piece1_orientation2 = [(1,1); (1,2); (2,2)]
let tromino_piece1_orientation2_corners = [(1,1); (1,2); (2,2)]
let tromino_piece1_orientation3 = [(1,2); (2,1); (2,2)]
let tromino_piece1_orientation3_corners = [(1,2); (2,1); (2,2)]
let tromino_piece1_orientation4 = [(1,1); (2,1); (2,2)]
let tromino_piece1_orientation4_corners = [(1,1); (2,1); (2,2)]


let tromino_piece2 = [(1,1); (2,1); (3,1)]
let tromino_piece2_orientation1 = [(1,1); (1,2); (1,3)]
(*
  x
  x
  x
  x

  x x x x
*)
let tetromino_piece1_orientation1 = [(1,1); (2,1); (3,1); (4,1)]
let tetromino_piece1_orientation1_corners = [(1,1); (4,1)]

let tetromino_piece1_orientation2 = [(1,1); (1,2); (1,3); (1,4)]
let tetromino_piece1_orientation2_corners = [(1,1); (1,4)]

(*
  x
  x x
  x

  x x x
    x

    x
  x x
    x

    x
  x x x
*)
let tetromino_piece2_orientation1 = [(1,1); (2,1); (3,1); (2,2)]
let tetromino_piece2_orientation1_corners = [(1,1); (3,1); (2,2)]
let tetromino_piece2_orientation2 = [(1,1); (1,2); (1,3); (2,2)]
let tetromino_piece2_orientation2_corners = [(1,1); (1,3); (2,2)]
let tetromino_piece2_orientation3 = [(2,1); (1,2); (2,2); (3,2)]
let tetromino_piece2_orientation3_corners = [(2,1); (1,2); (3,2)]
let tetromino_piece2_orientation4 = [(2,1); (2,2); (2,3); (1,2)]
let tetromino_piece2_orientation4_corners = [(2,1); (2,3); (1,2)]

(* 

    x
    x 
    x x

    x x x
    x

    x x
      x
      x

        x
    x x x
 *)


let tetromino_piece3_orientation1 = [(1,1); (2,1); (3,1); (3,2)]
let tetromino_piece3_orientation1_corner = [(1,1); (3,1); (3,2)]
let tetromino_piece3_orientation2 = [(1,1); (1,2); (1,3); (2,1)]
let tetromino_piece3_orientation2_corner = [(1,1); (1,3); (2,1)]
let tetromino_piece3_orientation3 = [(1,1); (1,2); (2,2); (3,2)]
let tetromino_piece3_orientation3_corner = [(1,1); (1,2); (3,2)]
let tetromino_piece3_orientation4 = [(2,1); (2,2); (2,3); (1,3)]
let tetromino_piece3_orientation4_corner = [(2,1); (2,3); (1,3)]


let pentomino_piece1_orientation1 = [(1,1); (2,1); (3,1); (4,1); (5,1)]
let pentomino_piece1_orientation1_corner = [(1,1); (5,1)]
let pentomino_piece1_orientation2 = [(1,1); (1,2); (1,3); (1,4); (1,5)]
let pentomino_piece1_orientation2_corner = [(1,1); (1,5)]

(* regular 1 line shape *)

(* 
    x 
    x 
    x
    x x

    x x x x
    x

  x x
    x
    x
    x

        x
  x x x x
 *)


let pentomino_piece2_orientation1 = [(1,1); (2,1); (3,1); (4,1); (4,2)] 
let pentomino_piece2_orientation1_corner = [(1,1); (4,1); (4,2)] 
let pentomino_piece2_orientation2 = [(1,1); (1,2); (1,3); (1,4); (2,1)] 
let pentomino_piece2_orientation2_corner = [(1,1); (1,4); (2,1)] 
let pentomino_piece2_orientation3 = [(1,1); (1,2); (2,2); (3,2); (4,2)] 
let pentomino_piece2_orientation3_corner = [(1,1); (1,2); (4,2)] 
let pentomino_piece2_orientation4 = [(1,4); (2,1); (2,2); (2,3); (2,4)] 
let pentomino_piece2_orientation4_corner = [(1,4); (2,1); (2,4)] 


(* 
    x 
    x x
    x x 

    x x x
    x x

    x x
    x x
    x

    x x
    x x x
 *)


let pentomino_piece3_orientation1 = [(1,1); (2,1); (3,1); (2,2); (3,2)]
let pentomino_piece3_orientation1_corner = [(1,1); (3,1); (2,2); (3,2)]
let pentomino_piece3_orientation2 = [(1,1); (1,2); (1,3); (2,1); (2,2)]
let pentomino_piece3_orientation2_corner = [(1,1); (1,3); (2,1); (2,2)]
let pentomino_piece3_orientation3 = [(1,1); (2,1); (1,2); (2,2); (3,2)]
let pentomino_piece3_orientation3_corner = [(1,1); (2,1); (1,2); (3,2)]
let pentomino_piece3_orientation4 = [(1,2); (1,3); (2,1); (2,2); (2,3)]
let pentomino_piece3_orientation4_corner = [(1,2); (1,3); (2,1); (2,3)]

let pentomino_piece4_orientation1 = [(1,1); (2,1); (3,1); (3,2); (4,2)]
let pentomino_piece4_orientation1_corners = [(1,1); (3,1); (3,2); (4,2)]
let pentomino_piece4_orientation2 = [(1,2); (2,2); (1,2); (1,3); (1,4)]
let pentomino_piece4_orientation2_corners = [(1,2); (2,2); (1,2); (1,4)]
let pentomino_piece4_orientation3 = [(1,1); (2,1); (2,2); (3,2); (4,2)]
let pentomino_piece4_orientation3_corners = [(1,1); (2,1); (2,2); (4,2)]
let pentomino_piece4_orientation4 = [(1,3); (1,4); (2,1); (2,2); (2,3)]
let pentomino_piece4_orientation4_corners = [(1,3); (1,4);(2,1); (2,3)]

(* 

    x x
    x
    x x

    x x x
    x   x

    x x
    x
    x x

    x   x
    x x x
 *)


let pentomino_piece5_orientation1 = [(1,1); (2,1); (3,1); (1,2); (3,2)]
let pentomino_piece5_orientation1_corners = [(1,1); (3,1); (1,2); (3,2)]
let pentomino_piece5_orientation2 = [(1,1); (1,2); (1,3); (2,1); (2,3)]
let pentomino_piece5_orientation2_corners = [(1,1); (1,3); (2,1); (2,3)]
let pentomino_piece5_orientation3 = [(1,1); (1,2); (2,2); (3,1); (3,2)]
let pentomino_piece5_orientation3_corners = [(1,1); (1,2); (3,1); (3,2)]
let pentomino_piece5_orientation4 = [(1,1); (1,3); (2,1); (2,2); (2,3)]
let pentomino_piece5_orientation4_corners = [(1,1); (1,3); (2,1); (2,3)]

(* 
x
x
x x x

x x x
x 
x 

x x x
    x
    x

    x
    x
x x x
 *)

let pentomino_piece6_orientation1 = [(1,1); (2,1); (3,1); (3,2); (3,3)]
let pentomino_piece6_orientation1_corners = [(1,1); (3,1); (3,3)]

let pentomino_piece6_orientation2 = [(1,1); (1,2); (1,3); (2,1); (3,1)]
let pentomino_piece6_orientation2_corners = [(1,1); (1,3); (3,1)]


let pentomino_piece6_orientation3 = [(1,1); (1,2); (1,3); (2,3); (3,3)]
let pentomino_piece6_orientation3_corners = [(1,1); (1,3); (3,3)]

let pentomino_piece6_orientation4 = [(1,3); (2,3); (3,1); (3,2); (3,3)]
let pentomino_piece6_orientation4_corners = [(1,3); (3,1); (3,3)]

(* 
  x
x x x
  x
 *)
let pentomino_piece7_orientation1 = [(1,2); (2,2); (3,2); (2,1); (2,3)]
let pentomino_piece7_orientation1_corners = [(1,2); (3,2); (2,1); (2,3)]


(** same_orientation returns true if two pieces, [piece1] and [piece2] are the 
    same piece with either the same exact orientation or a different orientation 
    or returns false otherwise, i.e. two unique/distinct pieces.*)
let rec same_orientation piece1 piece2 e =
  match piece1 with
  | [] -> true
  | h :: t -> 
    match piece2 with
    | [] -> true
    | a :: b ->
      if (h = a) then (
        same_orientation t b e
      ) else (
        false
      )

let return_inventory player =
  player.inventory

let rec placed_piece_helper inv piece =
  match inv with
  | [] -> failwith "Piece not in Inventory"
  | h :: t ->
    if (h = piece) then (
      t
    ) else (
      [h] @ placed_piece_helper t piece
    )

(** [placed_piece] returns the [player] with his/her inventory modified after
    removing the placed [piece] for their inventory. *)
let placed_piece piece player =
  {inventory = placed_piece_helper player.inventory piece; color = player.color; points = player.points}

let valid_moves (player_piece: piece ) : piece array = 
  failwith "Unimplemented"

let is_eliminated player_piece = 
  let pieces= valid_moves player_piece in
  if Array.length pieces= 0 then true
  else false


(* [is_touching_corner playerpiece game] checks that the placed piece touches the 
    corner of one of the pieces on the board *)
let is_touching_corner playerpiece board =
  let corner_positions = playerpiece.position_on_board_corners in
  let rec helper corner_positions board =
    match corner_positions with
    | [] -> false
    | (x,y)::t -> let continue = begin
        (* player.position_on_board has (x-1, y) then it has piece to the left
           player.position_on_board has (x+1, y) then it has piece to the right
           player.position_on_board has (x, y+1) then it has piece to the bottom
           player.position_on_board has (x, y-1) then it has piece to the top

           wwwwww
           rwwwww
           wwwwww


        *)
        let has_left= (y - 1 < 0) || (List.mem (x, y-1) playerpiece.position_on_board) 
        in 
        let has_right= (y + 1 >= Array.length board) || List.mem (x, y+1) playerpiece.position_on_board 
        in 
        let has_top= (x - 1 < 0) || List.mem (x-1, y) playerpiece.position_on_board 
        in 
        let has_bottom= (x + 1 >= Array.length board) || List.mem (x+1, y) playerpiece.position_on_board 
        in 
        if has_bottom && has_top <> true && has_left && has_right <> true then 
          begin if (board.(x-1).(y+1)) = playerpiece.color then true else false end  
        else if has_bottom && has_top <> true && has_left <> true && has_right  then begin
          if (board.(x-1).(y-1)) = playerpiece.color then true else false end 
        else if has_bottom <> true && has_top && has_left && has_right <> true then begin
          if (board.(x+1).(y+1)) = playerpiece.color then true else false end 
        else if (has_top && has_right) && not (has_bottom && has_left) then begin
          if (board.(x+1).(y-1)) = playerpiece.color then true else false end 
        else if has_top && has_bottom <> true && has_left <> true && has_right <> true then begin
          if ((board.(x+1).(y-1)) = playerpiece.color || (board.(x+1).(y+1)) = playerpiece.color) then true else false end 
        else if has_bottom && has_top <> true && has_left <>true  && has_right <> true then begin (* change *)
          if ((board.(x-1).(y-1)) = playerpiece.color || (board.(x-1).(y+1)) = playerpiece.color) then true else false end 
        else if has_left && has_bottom <> true && has_top <> true && has_right <>true then begin
          if ((board.(x-1).(y+1)) = playerpiece.color || (board.(x+1).(y+1)) = playerpiece.color) then true else false end 
        else if has_right && not has_bottom && not has_top && not has_left then begin
          if ((board.(x-1).(y-1)) = playerpiece.color || (board.(x+1).(y-1)) = playerpiece.color) then true else false end 
        else if has_bottom && has_top then false 
        else if has_right && has_left then false 
        else false end 
      in if continue then true else helper t board
  in 
  helper corner_positions board

(* [is_not_touching_face playerpiece game] checks that the placed piece does not 
   touch faces of pieces the same color. *)
let is_not_touching_face playerpiece board = 
  let all_positions = playerpiece.position_on_board in 
  let rec helper all_positions (board: game) =
    match all_positions with
    | [] -> true
    | (x,y)::t -> begin
        if ((x-1) >= 0) && board.(x-1).(y) = playerpiece.color then false 
        else if (x+ 1 < Array.length board) && board.(x+1).(y) = playerpiece.color then false 
        else if (y+ 1 < Array.length board) && board.(x).(y+1) = playerpiece.color then false 
        else if ((y-1) >= 0) && board.(x).(y-1) = playerpiece.color then false
        else helper t board end 
  in helper all_positions board



