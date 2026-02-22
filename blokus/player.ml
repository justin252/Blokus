(** Color variant — exhaustive pattern matching replaces char comparisons *)
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

let board_size = 20

let char_of_color = function
  | Blue -> 'B' | Green -> 'G' | Red -> 'R' | Yellow -> 'Y'

let color_of_char = function
  | 'B' -> Some Blue | 'G' -> Some Green
  | 'R' -> Some Red  | 'Y' -> Some Yellow
  | _ -> None

let mk_orient coords = { coordinates = coords }

(* --- Piece definitions --- *)

let monomino =
  { color = Blue;
    shape = [mk_orient [(0,0)]] }

let domino =
  { color = Blue;
    shape = [mk_orient [(0,0); (0,1)];
             mk_orient [(0,0); (1,0)]] }

let tromino_p1 =
  { color = Blue;
    shape = [mk_orient [(0,0); (0,1); (1,1)];
             mk_orient [(0,1); (1,0); (1,1)];
             mk_orient [(0,0); (1,0); (1,1)];
             mk_orient [(0,0); (0,1); (1,0)]] }

let tromino_p2 =
  { color = Blue;
    shape = [mk_orient [(0,0); (0,1); (0,2)];
             mk_orient [(0,0); (1,0); (2,0)]] }

let tetromino_p1 =
  { color = Blue;
    shape = [mk_orient [(0,0); (0,1); (1,0); (1,1)]] }

let tetromino_p2 =
  { color = Blue;
    shape = [mk_orient [(0,1); (1,0); (1,1); (1,2)];
             mk_orient [(0,0); (1,0); (1,1); (2,0)];
             mk_orient [(0,0); (0,1); (0,2); (1,1)];
             mk_orient [(0,1); (1,0); (1,1); (2,1)]] }

let tetromino_p3 =
  { color = Blue;
    shape = [mk_orient [(0,0); (0,1); (0,2); (0,3)];
             mk_orient [(0,0); (1,0); (2,0); (3,0)]] }

let tetromino_p4 =
  { color = Blue;
    shape = [mk_orient [(0,2); (1,0); (1,1); (1,2)];
             mk_orient [(0,0); (1,0); (2,0); (2,1)];
             mk_orient [(0,0); (0,1); (0,2); (1,0)];
             mk_orient [(0,0); (0,1); (1,1); (2,1)]] }

let tetromino_p5 =
  { color = Blue;
    shape = [mk_orient [(0,1); (0,2); (1,0); (1,1)];
             mk_orient [(0,0); (1,0); (1,1); (2,1)]] }

let pentomino_p1 =
  { color = Blue;
    shape = [mk_orient [(0,0); (1,0); (2,0); (3,0); (3,1)];
             mk_orient [(0,0); (0,1); (0,2); (0,3); (1,0)];
             mk_orient [(0,0); (0,1); (1,1); (2,1); (3,1)];
             mk_orient [(0,3); (1,0); (1,1); (1,2); (1,3)];
             mk_orient [(0,0); (0,1); (1,0); (2,0); (3,0)];
             mk_orient [(0,0); (1,0); (1,1); (1,2); (1,3)];
             mk_orient [(0,1); (1,1); (2,1); (3,0); (3,1)];
             mk_orient [(0,0); (0,1); (0,2); (0,3); (1,3)]] }

let pentomino_p2 =
  { color = Blue;
    shape = [mk_orient [(0,1); (1,1); (2,0); (2,1); (2,2)];
             mk_orient [(0,0); (1,0); (1,1); (1,2); (2,0)];
             mk_orient [(0,0); (0,1); (0,2); (1,1); (2,1)];
             mk_orient [(0,2); (1,0); (1,1); (1,2); (2,2)]] }

let pentomino_p3 =
  { color = Blue;
    shape = [mk_orient [(0,0); (1,0); (2,0); (2,1); (2,2)];
             mk_orient [(0,0); (0,1); (0,2); (1,0); (2,0)];
             mk_orient [(0,0); (0,1); (0,2); (1,2); (2,2)];
             mk_orient [(0,2); (1,2); (2,0); (2,1); (2,2)]] }

let pentomino_p4 =
  { color = Blue;
    shape = [mk_orient [(0,1); (0,2); (0,3); (1,0); (1,1)];
             mk_orient [(0,0); (1,0); (1,1); (2,1); (3,1)];
             mk_orient [(0,2); (0,3); (1,0); (1,1); (1,2)];
             mk_orient [(0,0); (1,0); (2,0); (2,1); (3,1)]] }

let pentomino_p5 =
  { color = Blue;
    shape = [mk_orient [(0,2); (1,0); (1,1); (1,2); (2,0)];
             mk_orient [(0,0); (0,1); (1,1); (2,1); (2,2)]] }

let pentomino_p6 =
  { color = Blue;
    shape = [mk_orient [(0,0); (1,0); (2,0); (3,0); (4,0)];
             mk_orient [(0,0); (0,1); (0,2); (0,3); (0,4)]] }

let pentomino_p7 =
  { color = Blue;
    shape = [mk_orient [(0,0); (1,0); (1,1); (2,0); (2,1)];
             mk_orient [(0,0); (0,1); (0,2); (1,0); (1,1)];
             mk_orient [(0,0); (0,1); (1,0); (1,1); (2,1)];
             mk_orient [(0,1); (0,2); (1,0); (1,1); (1,2)]] }

let pentomino_p8 =
  { color = Blue;
    shape = [mk_orient [(0,1); (0,2); (1,0); (1,1); (2,0)];
             mk_orient [(0,0); (0,1); (1,1); (1,2); (2,2)];
             mk_orient [(0,2); (1,1); (1,2); (2,0); (2,1)];
             mk_orient [(0,0); (1,0); (1,1); (2,1); (2,2)]] }

let pentomino_p9 =
  { color = Blue;
    shape = [mk_orient [(0,0); (0,1); (1,0); (2,0); (2,1)];
             mk_orient [(0,0); (0,1); (0,2); (1,0); (1,2)];
             mk_orient [(0,0); (0,1); (1,1); (2,0); (2,1)];
             mk_orient [(0,0); (0,2); (1,0); (1,1); (1,2)]] }

let pentomino_p10 =
  { color = Blue;
    shape = [mk_orient [(0,1); (0,2); (1,0); (1,1); (2,1)];
             mk_orient [(0,1); (1,0); (1,1); (1,2); (2,2)];
             mk_orient [(0,1); (1,1); (1,2); (2,0); (2,1)];
             mk_orient [(0,0); (1,0); (1,1); (1,2); (2,1)]] }

let pentomino_p11 =
  { color = Blue;
    shape = [mk_orient [(0,1); (1,0); (1,1); (1,2); (2,1)]] }

let pentomino_p12 =
  { color = Blue;
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

let player_red = { inventory = inventory_generator Red; color = Red }
let player_green = { inventory = inventory_generator Green; color = Green }
let player_blue = { inventory = inventory_generator Blue; color = Blue }
let player_yellow = { inventory = inventory_generator Yellow; color = Yellow }

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
    List.concat_map (fun (r, c) ->
      [(r-1, c-1); (r-1, c+1); (r+1, c-1); (r+1, c+1)]
    ) coords
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
  List.for_all (fun (r, c) -> board.(r).(c) = None) cells

(** check_corners: at least one cell must diagonally touch same color on board *)
let check_corners color cells (board : gameboard) =
  List.exists (fun (r, c) ->
    List.exists (fun (dr, dc) ->
      let nr = r + dr and nc = c + dc in
      nr >= 0 && nr < Array.length board &&
      nc >= 0 && nc < Array.length board.(0) &&
      not (List.mem (nr, nc) cells) &&
      board.(nr).(nc) = Some color
    ) [(-1,-1); (-1,1); (1,-1); (1,1)]
  ) cells

(** check_faces: no cell may share an edge with same color on board *)
let check_faces color cells (board : gameboard) =
  not (List.exists (fun (r, c) ->
    List.exists (fun (dr, dc) ->
      let nr = r + dr and nc = c + dc in
      nr >= 0 && nr < Array.length board &&
      nc >= 0 && nc < Array.length board.(0) &&
      board.(nr).(nc) = Some color
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

(* --- Player management (stdlib combinators replace manual recursion) --- *)

(** Remove first occurrence of piece from inventory via fold *)
let placed_piece piece player =
  let inv =
    List.fold_left (fun (found, acc) p ->
      if not found && p = piece then (true, acc)
      else (found, p :: acc)
    ) (false, []) player.inventory
    |> snd |> List.rev
  in
  { player with inventory = inv }

(** Next player in rotation — single function replaces get_next_index + get_player_helper + get_next_player *)
let get_next_player lst current =
  let indexed = List.mapi (fun i p -> (i, p)) lst in
  let idx = List.find (fun (_, p) -> p.color = current.color) indexed |> fst in
  let next_idx = (idx + 1) mod List.length lst in
  List.nth lst next_idx

(** Update player in list — List.map replaces manual recursion *)
let adjust_playerlist lst newplayer =
  List.map (fun p -> if p.color = newplayer.color then newplayer else p) lst

(** Remove player from list *)
let remove_player lst playerr =
  List.filter (fun p -> p.color <> playerr.color) lst

(** Find player in list (renamed from add_player for clarity) *)
let find_player lst playerr =
  match List.find_opt (fun p -> p.color = playerr.color) lst with
  | Some p -> [p]
  | None -> []

(** Score: each remaining cell in inventory = -1 point *)
let score player =
  player.inventory
  |> List.fold_left (fun acc p ->
    match p.shape with
    | [] -> acc
    | o :: _ -> acc - List.length o.coordinates
  ) 0
