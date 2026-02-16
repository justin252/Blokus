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
