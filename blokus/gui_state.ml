open Player

type t = {
  board : gameboard;
  players : player list;
  all_players : player list;
  current : player;
  selected_piece : int;
  selected_orient : int;
  first_moves : char list;
  game_over : bool;
}

let player_order = [player_blue; player_green; player_red; player_yellow]

let init () = {
  board = Array.init board_size (fun _ -> Array.make board_size '_');
  players = player_order;
  all_players = player_order;
  current = List.hd player_order;
  selected_piece = 0;
  selected_orient = 0;
  first_moves = List.map (fun p -> p.color) player_order;
  game_over = false;
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
  if st.game_over then st
  else
    let n = List.length st.current.inventory in
    if idx >= 0 && idx < n then
      { st with selected_piece = idx; selected_orient = 0 }
    else st

let cycle_orient st =
  if st.game_over then st
  else
    match current_piece st with
    | None -> st
    | Some p ->
      let n = List.length p.shape in
      { st with selected_orient = (st.selected_orient + 1) mod n }

let preview_cells st (row, col) =
  if st.game_over then None
  else
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

let advance_turn st players current =
  if List.length players = 0 then
    { st with players; game_over = true;
      selected_piece = 0; selected_orient = 0 }
  else
    let next = get_next_player players current in
    { st with players; current = next;
      selected_piece = 0; selected_orient = 0 }

let place st (row, col) =
  if st.game_over then st
  else
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
        let all_players = adjust_playerlist st.all_players updated_player in
        let first_moves =
          List.filter (fun c -> c <> color) st.first_moves
        in
        let st = { st with board = st.board; players; all_players; first_moves } in
        advance_turn st players updated_player

let pass st =
  if st.game_over then st
  else
    let players = remove_player st.players st.current in
    let all_players =
      adjust_playerlist st.all_players st.current
    in
    let st = { st with players; all_players } in
    advance_turn st players st.current

let scores st =
  List.map (fun p -> (p.color, score p)) st.all_players
