open Game
open Player
open Command

(*let play_blokus board player_list = 
  let players = ref player_list in
  while List.length !players <> 0 do
    print_board board;
    match parse (read_line ()) with
    | exception Malformed-> begin
        print_endline "Your command isn't right! Try again!";
        play_game_helper playerlist board playerpiece
      end
    | exception Empty-> begin
        print_endline "Your command is empty! Please enter a command!";
        play_game_helper playerlist board playerpiece
      end
    | Quit-> print_endline "Exit. Thank you for playing the game!"; Stdlib.exit 0
    | Continue -> play_game_helper playerlist board playerpiece
    | Choose t-> begin
      end*)

let rec play_game_helper playerlist board currplayer  =
  if List.length (playerlist) = 0 then  begin
    (*adjust score*)
    print_endline "Thank you for playing blokus! Here are the final scores:";
    (*print scores *)
    Stdlib.exit 0 
  end 
  else begin
    print_board board;
    print_newline ();
    (*check if inventory is empty*)
    print_pieces currplayer;
    print_endline "Choose piece you want to place. If you want to quit type 'quit'.";
    match parse (read_line ()) with
    | exception Malformed-> begin
        print_endline "Your command isn't right! Try again!";
        play_game_helper playerlist board currplayer
      end
    | exception Empty-> begin
        print_endline "Your command is empty! Please enter a command!";
        play_game_helper playerlist board currplayer
      end
    | Quit-> begin
        print_endline "Thank you for playing the game!"; 
        let updatedlist = remove_player playerlist currplayer in
        let next_player = get_next_player playerlist currplayer in
        play_game_helper updatedlist board next_player
      end
    | Continue -> play_game_helper playerlist board currplayer
    | Choose t-> begin
        let specificpiece = List.nth currplayer.inventory t in
        print_orientation specificpiece;
        print_endline "Choose orientation you want to place.";
        let spec_int = parse_int (read_line ()) in
        let specific_orien = List.nth specificpiece.shape spec_int in
        print_endline "Enter row # coordinate.";
        let x_coord = parse_int (read_line ()) in
        print_endline "Enter column # coordinate.";
        let y_coord = parse_int (read_line ()) in
        if is_valid specificpiece specific_orien.coordinates specific_orien.corners board (x_coord,y_coord)
        then begin
          let coordonboard = specificpiece.position_on_board in
          let newboard = update_board currplayer coordonboard board in
          let adjustedplayer = placed_piece specificpiece currplayer in
          let adjustedplayerlist = adjust_playerlist playerlist adjustedplayer in
          let next_player = get_next_player playerlist currplayer in
          print_int (List.length adjustedplayerlist);
          play_game_helper adjustedplayerlist newboard next_player
        end
        else begin
          print_endline "Invalid move! Your turn has been skipped!"; 
          let next_player = get_next_player playerlist currplayer in
          play_game_helper playerlist board next_player
        end
      end
  end
(** *)

(** [play_game f] starts the adventure in file [f]. *)
let play_game =
  let players = player_list in
  let official_board = Array.make_matrix 20 20 '_' in
  let currplayer = List.hd (players) in
  play_game_helper players official_board currplayer


(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  (**not printing this statement!!!*)
  ANSITerminal.(print_string [red] "\n\nWelcome to the 3110 Text Adventure Game engine.\n");
  play_game

(* Execute the game engine. *)


let () = main ()