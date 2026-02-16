open Player

let print_board (board:gameboard) =
  for i = 0 to Array.length board - 1 do
    print_newline ();
    for j = 0 to Array.length board.(i) - 1 do
      if board.(i).(j) = 'R' then
        ANSITerminal.(print_string [red] (String.make 1 (board.(i).(j))))
      else if board.(i).(j) = 'B' then
        ANSITerminal.(print_string [blue] (String.make 1 (board.(i).(j))))
      else if board.(i).(j) = 'G' then
        ANSITerminal.(print_string [green] (String.make 1 (board.(i).(j))))
      else if board.(i).(j) = 'Y' then
        ANSITerminal.(print_string [yellow] (String.make 1 (board.(i).(j))))
      else
        print_char board.(i).(j);
      print_char ' ';
    done
  done

let piece_printer piece =
  for i = 0 to Array.length piece - 1 do
    print_newline ();
    for j = 0 to Array.length piece.(i) - 1 do
      if piece.(i).(j) = 'R' then
        ANSITerminal.(print_string [red] (String.make 1 (piece.(i).(j))))
      else if piece.(i).(j) = 'B' then
        ANSITerminal.(print_string [blue] (String.make 1 (piece.(i).(j))))
      else if piece.(i).(j) = 'Y' then
        ANSITerminal.(print_string [yellow] (String.make 1 (piece.(i).(j))))
      else if piece.(i).(j) = 'G' then
        ANSITerminal.(print_string [green] (String.make 1 (piece.(i).(j))))
    done
  done

let piece_to_piecearray piece color =
  let matrix = Array.make_matrix 5 5 ' ' in
  let rec helper piece =
    match piece with
    | [] -> ()
    | (x,y)::t -> matrix.(x).(y) <- color; helper t
  in
  helper piece;
  matrix

let print_individual_piece indpiece color =
  let orien = indpiece.shape in
  let matrixofpiece =
    piece_to_piecearray (List.hd orien).coordinates color in
  piece_printer matrixofpiece

let print_pieces piecesplayer =
  let allpieces = piecesplayer.inventory in
  let rec helper allpieces index =
    match allpieces with
    | [] -> ()
    | h::t ->
      print_newline();
      print_string("Piece: " ^ string_of_int(index));
      print_individual_piece h piecesplayer.color;
      helper t (index+1)
  in
  helper allpieces 0

let player_list = [player_blue; player_green; player_red; player_yellow]

let update_board player coordinate board =
  let rec helper coordinate =
    match coordinate with
    | [] -> ()
    | (x,y)::t -> board.(x).(y) <- player.color; helper t
  in
  helper coordinate;
  board

let base_piece = [[' '; ' '; ' '; ' '; ' ']; [' '; ' '; ' '; ' '; ' '];
                  [' '; ' '; ' '; ' '; ' ']; [' '; ' '; ' '; ' '; ' '];
                  [' '; ' '; ' '; ' '; ' ']]

let print_char_list lst =
  let string_of_char_list l =
    String.concat " " (List.map (Char.escaped) l) in
  let char_list_to_string l =
    String.concat "\n" (List.map string_of_char_list l) in
  Printf.printf "%s" (char_list_to_string lst)

let rec change_val_cols b row color y =
  match row with
  | [] -> row
  | h :: t ->
    if b = y
    then color :: change_val_cols b t color (y+1)
    else h :: change_val_cols b t color (y+1)

let rec change_val_rows a b lst color x y =
  match lst with
  | [] -> lst
  | h :: t ->
    if a = x
    then change_val_cols b h color y :: change_val_rows a b t color (x+1) y
    else h :: change_val_rows a b t color (x+1) y

let rec fill_in_base base coordlst color =
  match coordlst with
  | [] -> base
  | (a, b) :: t ->
    let newbase = change_val_rows a b base color 0 0 in
    fill_in_base newbase t color

let rec orientation_print_helper lst num color =
  match lst with
  | [] -> print_newline ();
  | h :: t ->
    let coordlst = h.coordinates in
    print_string ("Orientation " ^ string_of_int num);
    print_newline ();
    print_char_list (fill_in_base base_piece coordlst color);
    print_newline ();
    orientation_print_helper t (num+1) color

let print_orientation piece =
  orientation_print_helper piece.shape 0 piece.color

let match_color color s =
  if color = 'R'
  then ANSITerminal.(print_string [red] ("Red Player: " ^ string_of_int s))
  else if color = 'Y'
  then ANSITerminal.(print_string [yellow] ("Yellow Player: " ^ string_of_int s))
  else if color = 'G'
  then ANSITerminal.(print_string [green] ("Green Player: " ^ string_of_int s))
  else if color = 'B'
  then ANSITerminal.(print_string [blue] ("Blue Player: " ^ string_of_int s))
  else failwith "impossible"

let rec print_scores playerlst =
  match playerlst with
  | [] -> print_newline ()
  | h :: t ->
    let s = score h in
    print_newline ();
    match_color h.color s;
    print_scores t
