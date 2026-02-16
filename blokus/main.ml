open Game
open Player
open Command

let rec play_game_helper playerlist board currplayer player_scores is_first =
  if List.length playerlist = 0 then begin
    print_endline "Thank you for playing blokus! Here are the final scores:";
    print_scores player_scores;
    Stdlib.exit 0
  end
  else begin
    print_board board;
    print_newline ();
    print_pieces currplayer;
    print_endline
      "Choose piece you want to place. If you want to quit type 'quit'.";
    match parse (read_line ()) with
    | exception Malformed ->
      print_endline "Your command isn't right! Try again!";
      play_game_helper playerlist board currplayer player_scores is_first
    | exception Empty ->
      print_endline "Your command is empty! Please enter a command!";
      play_game_helper playerlist board currplayer player_scores is_first
    | Quit ->
      print_endline "Thank you for playing the game!";
      let updatedlist = remove_player playerlist currplayer in
      let update_scorelist = add_player playerlist currplayer in
      let next_player = get_next_player playerlist currplayer in
      play_game_helper updatedlist board next_player update_scorelist false
    | Continue ->
      play_game_helper playerlist board currplayer player_scores is_first
    | Choose t ->
      if List.length currplayer.inventory <= t then begin
        print_endline "The piece does not exist! Try again!";
        play_game_helper playerlist board currplayer player_scores is_first
      end
      else
        let specificpiece = List.nth currplayer.inventory t in
        print_orientation specificpiece;
        print_endline "Choose orientation you want to place.";
        let spec_int = parse_int (read_line ()) in
        if List.length specificpiece.shape <= spec_int || spec_int < 0 then begin
          print_endline "The orientation does not exist! Try again!";
          play_game_helper playerlist board currplayer player_scores is_first
        end
        else
          let specific_orien = List.nth specificpiece.shape spec_int in
          print_endline "Enter row # coordinate.";
          let x_coord = parse_int (read_line ()) in
          print_endline "Enter column # coordinate.";
          let y_coord = parse_int (read_line ()) in
          match validate_placement currplayer.color
                  specific_orien.coordinates board
                  (x_coord, y_coord) is_first with
          | Some cells ->
            let newboard = update_board currplayer cells board in
            let adjustedplayer = placed_piece specificpiece currplayer in
            let adjustedplayerlist =
              adjust_playerlist playerlist adjustedplayer in
            let next_player = get_next_player playerlist currplayer in
            play_game_helper adjustedplayerlist newboard next_player
              player_scores false
          | None ->
            print_endline "Invalid move! Try again.";
            play_game_helper playerlist board currplayer player_scores is_first
  end

let play_game () =
  let players = player_list in
  let official_board = Array.make_matrix 20 20 '_' in
  let currplayer = List.hd players in
  play_game_helper players official_board currplayer [] true

let main () =
  ANSITerminal.(print_string [red] "\n\nWelcome to Blokus Game!\n\n");
  play_game ()

let () = main ()
