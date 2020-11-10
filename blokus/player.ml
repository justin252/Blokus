type square= {
  color: string;
  (* coordinate: (int * int); *)
}

(* 
type game = {
  gameboard: (square option) list list;
} *)
(* 
type game = square array array *)


type game = string array array


type orientation={
  coordinate: (int * int) list;
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
(* let is_touching_simple coordinate board = 

   if board.gameboard.((fst coordinate)-1).((snd coordinate)-1) <> 'W' then true 
   else if board.gameboard.((fst coordinate)-1).((snd coordinate)+1) <> 'W'then true
   else if board.gameboard.((fst coordinate)+1).((snd coordinate)-1) <> 'W'then true
   else if board.gameboard.((fst coordinate)+1).((snd coordinate)+1) <> 'W'then true
   else false  *)


let is_touching_corner playerpiece (board: game) =

  (* 
  {type game = square list list; }

  for i 
  for j
  if string = playerpiece.color then check for the conditions and add the coordinates 
  according to the condition


  *)
  (* 
  let st= board.((fst coordinate).(snd coordinate)) in
  if st.color= playerpiece.color then 
    begin match st with 

    end
  else  *)
  let corner_positions = playerpiece.position_on_board_corners in
  let rec helper corner_positions (board: game) =
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

(* has right only 
   has left only 
   has top only
   has bottom only
   has rig

   if R has R to the bottom and not the top and to the left but not the right, is_touching when coordinate if 
   the coordinate is (x1-1,y1-1) where R is (x1,y1)

   if R has R to the bottom and not the top and to the right but not the left, is_touching when coordinate if 
   the coordinate is (x1+1,y1-1) where R is (x1,y1)

   if R has R to the top and not the bottom and to the left but not the right, is_touching when coordinate if 
   the coordinate is (x1+1,y1+1) where R is (x1,y1)

   if R has R to the top and not the bottom and to the right but not the left, is_touching when coordinate if 
   the coordinate is (x1+1,y1-1) where R is (x1,y1)

   if R has R to the top and not the bottom and not to the right and not the left, is_touching when coordinate if 
   the coordinate is (x1-1,y1+1) or (x1+1,y+1)

   if R has R to the bottom and not the top and not to the right and not the left, is_touching when coordinate if 
   the coordinate is (x1-1,y1-1) or (x1+1,y-1)

   if R has R to the top and bottom, is_touching can't touch the piece anywhere
   if R has R to the left and right, is_touching can't touch the piece anywhere
   if R has R to the bottom and to the left and the right, is_touching can't touch the piece anywhere
   if R has R to the top and to the left and the right, is_touching can't touch the piece anywhere

   INDEX OUT OF RANGE THEN CATCH AND SAY FALSE

*)

(*                     
  W W W W W W R R R
  W W W W W R R W W
  W W R W W W W W W
  W R R W W W W W W
  R R R R W W W W W

  R R W
  R W W
  x x W

if for each block we want to look at all four sides and if its a the same color then we want to check
if it is the member of the piece coordinate list, if its not then its touching the face so return false

loop over the player piece coordinates and 
check for each box if (x-1, y) (x+1, y) (x, y+1) (x, y-1) has the same color as the piece. 
if it does then we wanna have a if else statement where
if it is a member of the piece coordinate list then continue looping else return false
  *)

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



