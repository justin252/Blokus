open Game
open Player
open Command

(** Game state record — consolidates 5 loose parameters *)
type game_state = {
  players : player list;
  board : gameboard;
  current : player;
  scores : player list;
  is_first : bool;
}

let handle_quit st =
  print_endline "Thank you for playing the game!";
  let next = get_next_player st.players st.current in
  { st with
    players = remove_player st.players st.current;
    scores = find_player st.players st.current;
    current = next;
    is_first = false }

let handle_choose st t =
  if List.length st.current.inventory <= t then begin
    print_endline "The piece does not exist! Try again!"; st
  end else
    let piece = List.nth st.current.inventory t in
    print_orientation piece;
    print_endline "Choose orientation you want to place.";
    match parse_int (read_line ()) with
    | None ->
      print_endline "Invalid orientation! Try again."; st
    | Some spec_int ->
      if List.length piece.shape <= spec_int || spec_int < 0 then begin
        print_endline "The orientation does not exist! Try again!"; st
      end else
        let orient = List.nth piece.shape spec_int in
        print_endline "Enter row # coordinate.";
        let x_coord = match parse_int (read_line ()) with
          | Some n -> n | None -> -1 in
        print_endline "Enter column # coordinate.";
        let y_coord = match parse_int (read_line ()) with
          | Some n -> n | None -> -1 in
        match validate_placement st.current.color
                orient.coordinates st.board
                (x_coord, y_coord) st.is_first with
        | Some cells ->
          let newboard = update_board st.current cells st.board in
          let updated = placed_piece piece st.current in
          let next = get_next_player st.players st.current in
          { st with
            board = newboard;
            players = adjust_playerlist st.players updated;
            current = next;
            is_first = false }
        | None ->
          print_endline "Invalid move! Try again."; st

(** Main game loop — pattern match on parse_result instead of catching exceptions *)
let rec play_game_loop st =
  match st.players with
  | [] ->
    print_endline "Thank you for playing blokus! Here are the final scores:";
    print_scores st.scores;
    Stdlib.exit 0
  | _ ->
    print_board st.board;
    print_newline ();
    print_pieces st.current;
    print_endline
      "Choose piece you want to place. If you want to quit type 'quit'.";
    let st' = match parse (read_line ()) with
      | Bad_input ->
        print_endline "Your command isn't right! Try again!"; st
      | Empty_input ->
        print_endline "Your command is empty! Please enter a command!"; st
      | Ok Quit -> handle_quit st
      | Ok Continue -> st
      | Ok (Choose t) -> handle_choose st t
    in
    play_game_loop st'

let play_game () =
  let players = player_list in
  let board = Array.init 20 (fun _ -> Array.make 20 None) in
  let st = {
    players;
    board;
    current = List.hd players;
    scores = [];
    is_first = true;
  } in
  play_game_loop st

let main () =
  ANSITerminal.(print_string [red] "\n\nWelcome to Blokus Game!\n\n");
  play_game ()

let () = main ()
