open Player

type t = {
  board : gameboard;
  players : player list;
  current : player;
  selected_piece : int;
  selected_orient : int;
  first_moves : char list;
}

let player_order = [player_blue; player_green; player_red; player_yellow]

let init () = {
  board = Array.init board_size (fun _ -> Array.make board_size '_');
  players = player_order;
  current = List.hd player_order;
  selected_piece = 0;
  selected_orient = 0;
  first_moves = List.map (fun p -> p.color) player_order;
}

let is_first_move st =
  List.mem st.current.color st.first_moves

let current_piece st =
  List.nth_opt st.current.inventory st.selected_piece

let current_coords st =
  match current_piece st with
  | None -> None
  | Some p ->
    let orient = List.nth p.shape st.selected_orient in
    Some orient.coordinates

let select_piece st idx =
  let n = List.length st.current.inventory in
  if idx >= 0 && idx < n then
    { st with selected_piece = idx; selected_orient = 0 }
  else st

let cycle_orient st =
  match current_piece st with
  | None -> st
  | Some p ->
    let n = List.length p.shape in
    { st with selected_orient = (st.selected_orient + 1) mod n }

let preview_cells st (row, col) =
  match current_coords st with
  | None -> None
  | Some coords ->
    let color = st.current.color in
    match validate_placement color coords st.board (row, col) (is_first_move st) with
    | Some cells -> Some (cells, true)
    | None ->
      let cells = translate coords (row, col) in
      let in_bounds = List.filter (fun (r, c) ->
        r >= 0 && r < board_size && c >= 0 && c < board_size
      ) cells in
      Some (in_bounds, false)

let place st (row, col) =
  match current_coords st with
  | None -> st
  | Some coords ->
    let color = st.current.color in
    match validate_placement color coords st.board (row, col) (is_first_move st) with
    | None -> st
    | Some cells ->
      List.iter (fun (r, c) -> st.board.(r).(c) <- color) cells;
      let piece = List.nth st.current.inventory st.selected_piece in
      let updated_player = placed_piece piece st.current in
      let players = adjust_playerlist st.players updated_player in
      let next = get_next_player players updated_player in
      let first_moves =
        List.filter (fun c -> c <> color) st.first_moves
      in
      { board = st.board;
        players;
        current = next;
        selected_piece = 0;
        selected_orient = 0;
        first_moves;
      }
