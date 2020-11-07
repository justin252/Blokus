
type game = {
  gameboard: char array array
}

type orientation={
  coordinates: (int * int) list;
  corners: (int * int) list
}

type piece = {
  color : string;
  positiononboard: (int*int) list;
  shape : orientation list
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


let corners_of_player_piece playerpiece = 
  let corner = [] in
  let corner1 = if playerpiece.(0).(0) then (0,0)::corner else corner in
  let corner2 = if playerpiece.(0).(4) then (0,4)::corner1 else corner1 in
  let corner3 = if playerpiece.(4).(0) then (4,0)::corner2 else corner2 in
  let corner4 = if playerpiece.(4).(4) then (4,4)::corner3 else corner3 in
  corner4

let check_right_left_i_z j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(0).(j+1) = false && playerpiece.(0).(j-1) = false then (0,j)::empty else empty in
  corner

let check_right_left_i_f j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(4).(j+1) = false && playerpiece.(4).(j-1) = false then (4,j)::empty else empty in
  corner

let check_right_bottom_i j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(0).(j+1) = false  && playerpiece.(1).(j) = false then (0,j)::empty else empty in
  corner

let check_right_top_i j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(4).(j+1) = false  && playerpiece.(3).(j) = false then (4,j)::empty else empty in
  corner

let check_left_bottom_i j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(0).(j-1) = false && playerpiece.(1).(j) = false then (0,j)::empty else empty in
  corner

let check_left_top_i j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(4).(j-1) = false && playerpiece.(3).(j) = false then (4,j)::empty else empty in
  corner

let check_i_zero j playerpiece = 
  let empty = [] in 
  if check_right_left_i_z j playerpiece <> [] then check_right_left_i_z j playerpiece
  else if check_right_bottom_i j playerpiece <> [] then check_right_bottom_i j playerpiece
  else if check_left_bottom_i j playerpiece <> [] then check_left_bottom_i j playerpiece
  else empty

let check_i_four j playerpiece = 
  let empty = [] in 
  if check_right_left_i_f j playerpiece <> [] then check_right_left_i_f j playerpiece
  else if check_right_top_i j playerpiece <> [] then check_right_top_i j playerpiece
  else if check_left_top_i j playerpiece <> [] then check_left_top_i j playerpiece
  else empty

let check_top_bottom_z_j i playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i-1).(0) = false && playerpiece.(i+1).(0) = false then (i,0)::empty else empty in
  corner

let check_right_bottom_j i playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i).(1) = false && playerpiece.(i-1).(0) = false then (i,0)::empty else empty in
  corner

let check_right_top i playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i).(1) = false && playerpiece.(i-1).(0) = false then (i,0)::empty else empty in
  corner

let check_top_bottom_f_j i playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i-1).(4) = false && playerpiece.(i+1).(4) = false then (i,4)::empty else empty in
  corner

let check_left_top_j i playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i).(3) = false && playerpiece.(i-1).(4) = false then (i,4)::empty else empty in
  corner

let check_left_bottom_j i playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i).(3) = false && playerpiece.(i+1).(4) = false then (i,4)::empty else empty in
  corner



let check_j_zero i playerpiece = 
  let empty =[] in 
  if check_top_bottom_z_j i playerpiece <> [] then check_top_bottom_z_j i playerpiece
  else if check_right_bottom_j i playerpiece <> [] then check_right_bottom_j i playerpiece
  else if check_right_top i playerpiece <> [] then check_right_top i playerpiece
  else empty

let check_j_four i playerpiece = 
  let empty =[] in 
  if check_top_bottom_f_j i playerpiece <> [] then check_top_bottom_f_j i playerpiece
  else if check_left_top_j i playerpiece <> [] then check_left_top_j i playerpiece
  else if check_left_bottom_j i playerpiece <> [] then check_left_bottom_j i playerpiece
  else empty

let check_right_left_top i j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i).(j+1) = false && playerpiece.(i).(j-1) = false && playerpiece.(i-1).(j) = false then (i,j)::empty else empty in
  corner

let check_bottom_left_top i j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i+1).(j) = false && playerpiece.(i).(j-1) = false && playerpiece.(i-1).(j) = false then (i,j)::empty else empty in
  corner

let check_bottom_right_top i j playerpiece = 
  let empty = [] in
  let corner = if playerpiece.(i+1).(j) = false && playerpiece.(i).(j-1) = false && playerpiece.(i-1).(j) = false then (i,j)::empty else empty in
  corner

let check_any i j playerpiece = 
  let empty =[] in 
  if check_right_left_top i j playerpiece <> [] then check_right_left_top i j playerpiece
  else if check_bottom_left_top i j playerpiece <> [] then check_bottom_left_top i j playerpiece
  else if check_bottom_right_top i j playerpiece <> [] then check_bottom_right_top i j playerpiece
  else empty


let find_corners_in_player_piece playerpiece = 
  let all_corners = ref [] in
  for i = 0 to 4 do
    for j = 0 to 4 do
      if i=0 && j<>0 && j<>4 && playerpiece.(i).(j) then all_corners := (check_i_zero j playerpiece)@ !all_corners
      else if j=0 && i<>0 && i<>4 && playerpiece.(i).(j) then all_corners := (check_j_zero i playerpiece)@ !all_corners
      else if i<>0 && j<>0 && j<>4 && i<>4 && playerpiece.(i).(j) then all_corners := (check_any i j playerpiece)@ !all_corners
      else if i=4 && j<>0 && j<>4 && playerpiece.(i).(j) then all_corners := (check_i_four j playerpiece)@ !all_corners
      else if j=4 && i<>0 && i<>4 && playerpiece.(i).(j) then all_corners := (check_j_four i playerpiece)@ !all_corners
      else all_corners := !all_corners
    done
  done;
  !all_corners

let get_all_corners playerpiece = 
  let check_corner_array = corners_of_player_piece playerpiece in
  let check_rest_of_array = find_corners_in_player_piece playerpiece in
  let all = check_corner_array@check_rest_of_array in
  all

(** [is_touching player game] sees that the placed piece touches just the 
    corner of one of the pieces on the board and does not touch the faces 
    of it’s other pieces. *)
let is_touching_simple coordinate board = 
  if board.gameboard.((fst coordinate)-1).((snd coordinate)-1) <> 'W' then true 
  else if board.gameboard.((fst coordinate)-1).((snd coordinate)+1) <> 'W'then true
else if board.gameboard.((fst coordinate)+1).((snd coordinate)-1) <> 'W'then true
else if board.gameboard.((fst coordinate)+1).((snd coordinate)+1) <> 'W'then true
else false 


let rec is_touching playerpiece coordinate board lst = 
  (*let allcorners = find_corners_in_player_piece playerpiece in*)
  match lst with
  |[] -> false
  |(x,y)::t-> if (x-1) = (fst coordinate) && (y+1) = (snd coordinate)then true 
    else if (x+1) = (fst coordinate) && (y-1) = (snd coordinate)then true
    else if (x-1) = (fst coordinate) && (y-1) = (snd coordinate)then true
    else if (x+1) = (fst coordinate) && (y+1) = (snd coordinate)then true
    else is_touching playerpiece coordinate board t
