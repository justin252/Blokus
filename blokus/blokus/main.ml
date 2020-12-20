open Game
open Player
open Command

let rec play_game_helper playerlist board currplayer player_scores =
  if List.length (playerlist) = 0 then  begin
    (*adjust score*)
    print_endline "Thank you for playing blokus! Here are the final scores:";
    print_scores player_scores;
    Stdlib.exit 0 
  end 
  else begin
    print_board board;
    print_newline ();
    (*check if inventory is empty*)
    print_pieces currplayer;
    print_endline 
      "Choose piece you want to place. If you want to quit type 'quit'. 
      If you want to terminate game type 'end'";
    match parse (read_line ()) with
    | exception Malformed-> begin
        print_endline "Your command isn't right! Try again!";
        play_game_helper playerlist board currplayer player_scores
      end
    | exception Empty-> begin
        print_endline "Your command is empty! Please enter a command!";
        play_game_helper playerlist board currplayer player_scores
      end
    | Quit-> begin
        print_endline "Thank you for playing the game!";
        let update_scorelist = 
          add_player player_scores playerlist currplayer in 
        let updatedlist = remove_player playerlist currplayer in
        let next_player = get_next_player playerlist currplayer in
        play_game_helper updatedlist board next_player update_scorelist
      end
    | Continue -> play_game_helper playerlist board currplayer player_scores
    | Choose t-> begin
        if List.length currplayer.inventory <= t then begin 
          print_endline "The piece does not exist! Try again!";
          play_game_helper playerlist board currplayer player_scores end
        else
          let specificpiece = List.nth currplayer.inventory t in
          print_orientation specificpiece;
          print_endline "Choose orientation you want to place.";
          let spec_int = parse_int (read_line ()) in
          if List.length specificpiece.shape <= spec_int then begin 
            print_endline "The orientation does not exist! Try again!";
            play_game_helper playerlist board currplayer player_scores end
          else
            let specific_orien = List.nth specificpiece.shape spec_int in
            (*add try catch for nth exception*)
            print_endline "Enter row # coordinate.";
            let x_coord = parse_int (read_line ()) in
            print_endline "Enter column # coordinate.";
            let y_coord = parse_int (read_line ()) in
            if is_valid specificpiece specific_orien.coordinates 
                specific_orien.corners board (x_coord,y_coord)
            then begin
              let coordonboard = specificpiece.position_on_board in
              let newboard = update_board currplayer coordonboard board in
              let addpoints_player = add_points specificpiece currplayer in
              let adjustedplayer = 
                placed_piece specificpiece addpoints_player in
              let adjustedplayerlist = 
                adjust_playerlist playerlist adjustedplayer in
              let next_player = get_next_player playerlist currplayer in
              play_game_helper adjustedplayerlist newboard 
                next_player player_scores
            end
            else begin
              print_endline "Invalid move! Your turn has been skipped!"; 
              let next_player = get_next_player playerlist currplayer in
              play_game_helper playerlist board next_player player_scores
            end
      end
    |EndGame ->
      print_endline "Thank you for playing blokus! Here are the final scores:";
      print_scores player_scores;
      Stdlib.exit 0 
  end
(** *)

(** [play_game f] starts the adventure in file [f]. *)
let play_game ()=
  let players = player_list in
  let official_board = Array.make_matrix 20 20 '-' in
  let currplayer = List.hd (players) in
  play_game_helper players official_board currplayer []


(** [main ()] prompts for the game to play, then starts it. *)
let main () =

  ANSITerminal.(print_string [red] "\n\nWelcome to Blokus Game!
  Game Rules: (Official General Blokus Rules)
 - There are four players in the game (Red, Blue, Green and Yellow) and each 
 of them have a set of 21 pieces.
 - The first piece played by each player must be placed to cover their corner 
 of the board.
 - Each player must place a piece such that the block placed must touch one of 
 the corners of its own piece already on the board but should not touch any of 
 the faces of its own color.
 - There are no restrictions on how many pieces of different colors may be in 
 contact with each other.
 - Once a piece has been placed on the board it cannot be moved during 
 subsequent turns.
 - The game ends when all players quit the game
 - Scores are tallied after each round by adding the number of the blocks 
 placed on the board to the players cumulative sum and the player with the 
 highest score is the winner.
GAME PLAY DIRECTIONS:
During each player’s turn, they will be given a choice on whether they want to 
quit the game if they think they don’t have any remaining moves by entering 
“quit”. If they choose to quit the game, they will be removed from the game and 
the next player will be prompted to make a decision. If they want to place a 
piece, they can enter the number for the piece they want to place. for example, 
if they want to place the piece labeled number 2 they can enter the command “2” 
If they enter a number not present in their inventory, they will be prompted to 
choose another piece.
The player will then be prompted to choose the orientation for the piece. 
For example, if they want to choose orientation 2 they can enter the command 
“2” If they enter a number not present in their inventory, they will be 
prompted to choose another piece. The player will then be prompted to place the 
piece on the board. They will choose the coordinates of the left-most and 
top-most coordinate of their selected piece. If the placed piece position 
is valid, i.e it touches the corner of one if the same colored pieces on the 
board but does not touch any of the faces of same colored pieces and does not 
overlap on any of the existing pieces on the board, the piece will be placed. 
Then another player will be prompted to do the same. If the placed piece 
position is invalid, the player’s turn will be skipped.
The game ends when all four players have chosen to quit the game.
The final scores will be displayed and the player with the highest number of 
votes wins the game.
 \n");
  play_game ()


let () = main ()