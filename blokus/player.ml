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

let board_size = 20

let mk_orient coords = { coordinates = coords }

(* --- Piece definitions --- *)

let monomino =
  { color = 'W';
    shape = [mk_orient [(0,0)]] }

let domino =
  { color = 'W';
    shape = [mk_orient [(0,0); (0,1)];
             mk_orient [(0,0); (1,0)]] }

let tromino_p1 =
  { color = 'W';
    shape = [mk_orient [(0,0); (0,1); (1,1)];
             mk_orient [(0,1); (1,0); (1,1)];
             mk_orient [(0,0); (1,0); (1,1)];
             mk_orient [(0,0); (0,1); (1,0)]] }

let tromino_p2 =
  { color = 'W';
    shape = [mk_orient [(0,0); (0,1); (0,2)];
             mk_orient [(0,0); (1,0); (2,0)]] }

let tetromino_p1 =
  { color = 'W';
    shape = [mk_orient [(0,0); (0,1); (1,0); (1,1)]] }

let tetromino_p2 =
  { color = 'W';
    shape = [mk_orient [(0,1); (1,0); (1,1); (1,2)];
             mk_orient [(0,0); (1,0); (1,1); (2,0)];
             mk_orient [(0,0); (0,1); (0,2); (1,1)];
             mk_orient [(0,1); (1,0); (1,1); (2,1)]] }

let tetromino_p3 =
  { color = 'W';
    shape = [mk_orient [(0,0); (0,1); (0,2); (0,3)];
             mk_orient [(0,0); (1,0); (2,0); (3,0)]] }

let tetromino_p4 =
  { color = 'W';
    shape = [mk_orient [(0,2); (1,0); (1,1); (1,2)];
             mk_orient [(0,0); (1,0); (2,0); (2,1)];
             mk_orient [(0,0); (0,1); (0,2); (1,0)];
             mk_orient [(0,0); (0,1); (1,1); (2,1)]] }

let tetromino_p5 =
  { color = 'W';
    shape = [mk_orient [(0,1); (0,2); (1,0); (1,1)];
             mk_orient [(0,0); (1,0); (1,1); (2,1)]] }

(* L-pentomino: 8 orientations (4 rotations × 2 reflections) *)
let pentomino_p1 =
  { color = 'W';
    shape = [mk_orient [(0,0); (1,0); (2,0); (3,0); (3,1)];
             mk_orient [(0,0); (0,1); (0,2); (0,3); (1,0)];
             mk_orient [(0,0); (0,1); (1,1); (2,1); (3,1)];
             mk_orient [(0,3); (1,0); (1,1); (1,2); (1,3)];
             mk_orient [(0,0); (0,1); (1,0); (2,0); (3,0)];
             mk_orient [(0,0); (1,0); (1,1); (1,2); (1,3)];
             mk_orient [(0,1); (1,1); (2,1); (3,0); (3,1)];
             mk_orient [(0,0); (0,1); (0,2); (0,3); (1,3)]] }

let pentomino_p2 =
  { color = 'W';
    shape = [mk_orient [(0,1); (1,1); (2,0); (2,1); (2,2)];
             mk_orient [(0,0); (1,0); (1,1); (1,2); (2,0)];
             mk_orient [(0,0); (0,1); (0,2); (1,1); (2,1)];
             mk_orient [(0,2); (1,0); (1,1); (1,2); (2,2)]] }

let pentomino_p3 =
  { color = 'W';
    shape = [mk_orient [(0,0); (1,0); (2,0); (2,1); (2,2)];
             mk_orient [(0,0); (0,1); (0,2); (1,0); (2,0)];
             mk_orient [(0,0); (0,1); (0,2); (1,2); (2,2)];
             mk_orient [(0,2); (1,2); (2,0); (2,1); (2,2)]] }

let pentomino_p4 =
  { color = 'W';
    shape = [mk_orient [(0,1); (0,2); (0,3); (1,0); (1,1)];
             mk_orient [(0,0); (1,0); (1,1); (2,1); (3,1)];
             mk_orient [(0,2); (0,3); (1,0); (1,1); (1,2)];
             mk_orient [(0,0); (1,0); (2,0); (2,1); (3,1)]] }

let pentomino_p5 =
  { color = 'W';
    shape = [mk_orient [(0,2); (1,0); (1,1); (1,2); (2,0)];
             mk_orient [(0,0); (0,1); (1,1); (2,1); (2,2)]] }

let pentomino_p6 =
  { color = 'W';
    shape = [mk_orient [(0,0); (1,0); (2,0); (3,0); (4,0)];
             mk_orient [(0,0); (0,1); (0,2); (0,3); (0,4)]] }

let pentomino_p7 =
  { color = 'W';
    shape = [mk_orient [(0,0); (1,0); (1,1); (2,0); (2,1)];
             mk_orient [(0,0); (0,1); (0,2); (1,0); (1,1)];
             mk_orient [(0,0); (0,1); (1,0); (1,1); (2,1)];
             mk_orient [(0,1); (0,2); (1,0); (1,1); (1,2)]] }

let pentomino_p8 =
  { color = 'W';
    shape = [mk_orient [(0,1); (0,2); (1,0); (1,1); (2,0)];
             mk_orient [(0,0); (0,1); (1,1); (1,2); (2,2)];
             mk_orient [(0,2); (1,1); (1,2); (2,0); (2,1)];
             mk_orient [(0,0); (1,0); (1,1); (2,1); (2,2)]] }

let pentomino_p9 =
  { color = 'W';
    shape = [mk_orient [(0,0); (0,1); (1,0); (2,0); (2,1)];
             mk_orient [(0,0); (0,1); (0,2); (1,0); (1,2)];
             mk_orient [(0,0); (0,1); (1,1); (2,0); (2,1)];
             mk_orient [(0,0); (0,2); (1,0); (1,1); (1,2)]] }

let pentomino_p10 =
  { color = 'W';
    shape = [mk_orient [(0,1); (0,2); (1,0); (1,1); (2,1)];
             mk_orient [(0,1); (1,0); (1,1); (1,2); (2,2)];
             mk_orient [(0,1); (1,1); (1,2); (2,0); (2,1)];
             mk_orient [(0,0); (1,0); (1,1); (1,2); (2,1)]] }

let pentomino_p11 =
  { color = 'W';
    shape = [mk_orient [(0,1); (1,0); (1,1); (1,2); (2,1)]] }

let pentomino_p12 =
  { color = 'W';
    shape = [mk_orient [(0,1); (1,0); (1,1); (1,2); (1,3)];
             mk_orient [(0,0); (1,0); (1,1); (2,0); (3,0)];
             mk_orient [(0,0); (0,1); (0,2); (0,3); (1,2)];
             mk_orient [(0,1); (1,1); (2,0); (2,1); (3,1)]] }

let pieces =
  [monomino; domino; tromino_p1; tromino_p2;
   tetromino_p1; tetromino_p2; tetromino_p3; tetromino_p4; tetromino_p5;
   pentomino_p1; pentomino_p2; pentomino_p3; pentomino_p4; pentomino_p5;
   pentomino_p6; pentomino_p7; pentomino_p8; pentomino_p9;
   pentomino_p10; pentomino_p11; pentomino_p12]

let set_color c (p : piece) = { p with color = c }

let inventory_generator c = List.map (set_color c) pieces

let player_red = { inventory = inventory_generator 'R'; color = 'R' }
let player_green = { inventory = inventory_generator 'G'; color = 'G' }
let player_blue = { inventory = inventory_generator 'B'; color = 'B' }
let player_yellow = { inventory = inventory_generator 'Y'; color = 'Y' }

(* --- Core game logic --- *)

let compute_corners coords =
  let is_cell (r, c) = List.exists (fun (cr, cc) -> cr = r && cc = c) coords in
  let is_face_adjacent (r, c) =
    List.exists (fun (cr, cc) ->
      (cr = r - 1 && cc = c) || (cr = r + 1 && cc = c) ||
      (cr = r && cc = c - 1) || (cr = r && cc = c + 1)
    ) coords
  in
  let diags =
    List.flatten (List.map (fun (r, c) ->
      [(r-1, c-1); (r-1, c+1); (r+1, c-1); (r+1, c+1)]
    ) coords)
  in
  let unique = List.sort_uniq compare diags in
  List.filter (fun pos -> not (is_cell pos) && not (is_face_adjacent pos)) unique

let translate coords (dr, dc) =
  List.map (fun (r, c) -> (r + dr, c + dc)) coords

let all_in_bounds cells =
  List.for_all (fun (r, c) ->
    r >= 0 && r < board_size && c >= 0 && c < board_size
  ) cells

let all_empty cells (board : gameboard) =
  List.for_all (fun (r, c) -> board.(r).(c) = '_') cells

let check_corners color cells (board : gameboard) =
  List.exists (fun (r, c) ->
    List.exists (fun (dr, dc) ->
      let nr = r + dr and nc = c + dc in
      nr >= 0 && nr < Array.length board &&
      nc >= 0 && nc < Array.length board.(0) &&
      not (List.mem (nr, nc) cells) &&
      board.(nr).(nc) = color
    ) [(-1,-1); (-1,1); (1,-1); (1,1)]
  ) cells

let check_faces color cells (board : gameboard) =
  not (List.exists (fun (r, c) ->
    List.exists (fun (dr, dc) ->
      let nr = r + dr and nc = c + dc in
      nr >= 0 && nr < Array.length board &&
      nc >= 0 && nc < Array.length board.(0) &&
      board.(nr).(nc) = color
    ) [(-1,0); (1,0); (0,-1); (0,1)]
  ) cells)

let starting_pos cells =
  let corners = [(0,0); (0, board_size - 1);
                 (board_size - 1, 0); (board_size - 1, board_size - 1)] in
  List.exists (fun c -> List.mem c cells) corners

let validate_placement color coords board offset is_first_move =
  let cells = translate coords offset in
  if not (all_in_bounds cells) then None
  else if not (all_empty cells board) then None
  else if not (check_faces color cells board) then None
  else if is_first_move then
    (if starting_pos cells then Some cells else None)
  else
    (if check_corners color cells board then Some cells else None)

(* --- Player management --- *)

let rec placed_piece_helper inv piece =
  match inv with
  | [] -> failwith "Piece not in Inventory"
  | h :: t ->
    if h = piece then t
    else h :: placed_piece_helper t piece

let placed_piece piece player =
  { inventory = placed_piece_helper player.inventory piece;
    color = player.color }

let rec get_next_index lst current x =
  match lst with
  | [] -> failwith "impossible"
  | h :: _ when h.color = current.color -> x
  | _ :: t -> get_next_index t current (x + 1)

let rec get_player_helper lst index num =
  match lst with
  | [] -> failwith "impossible"
  | h :: _ when index = num -> h
  | _ :: t -> get_player_helper t index (num + 1)

let get_next_player lst current =
  let index = get_next_index lst current 0 in
  if index = List.length lst - 1
  then get_player_helper lst 0 0
  else get_player_helper lst (index + 1) 0

let rec adjust_playerlist lst newplayer =
  match lst with
  | [] -> []
  | h :: t ->
    if h.color = newplayer.color then newplayer :: t
    else h :: adjust_playerlist t newplayer

let rec remove_player lst playerr =
  match lst with
  | [] -> []
  | h :: t ->
    if h.color = playerr.color then t
    else h :: remove_player t playerr

let rec add_player lst playerr =
  match lst with
  | [] -> []
  | h :: _ when h.color = playerr.color -> [h]
  | _ :: t -> add_player t playerr

let score player =
  let cell_count piece =
    match piece.shape with
    | [] -> 0
    | o :: _ -> List.length o.coordinates
  in
  List.fold_left (fun acc p -> acc - cell_count p) 0 player.inventory
