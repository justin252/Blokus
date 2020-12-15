open Player

let print_board (board:gameboard) =
  let printerbaord = board in
  for i = 0 to Array.length printerbaord - 1 do 
    print_newline ();
    for j = 0 to Array.length printerbaord.(i) - 1 do
      print_char printerbaord.(i).(j);
      print_char ' ';
    done
  done

let piece_printer piece =
  for i = 0 to Array.length piece -1 do
    print_newline ();
    for j = 0 to Array.length piece.(i) -1 do
      print_char piece.(i).(j)
    done
  done


let piece_to_piecearray piece color= 
  let matrix = Array.make_matrix 5 5 ' ' in
  let rec helper piece =
    match piece with
    |[]->[]
    |(x,y)::t -> matrix.(x).(y) <- color; helper t
  in
  helper piece;
  matrix

let print_individual_piece indpiece color = 
  let orien = indpiece.shape in
  let get_first orien = 
    match orien with
    |[]->None
    |h::t -> Some h
  in
  let matrixofpiece =  
    piece_to_piecearray (List.hd orien).coordinates color in
  piece_printer matrixofpiece


let print_pieces piecesplayer = 
  let allpieces = piecesplayer.inventory in
  let rec helper allpieces index = 
    match allpieces with
    |[] -> []
    |h::t -> begin
        print_newline();
        print_string("Piece: "^ string_of_int(index)); 
        print_individual_piece h piecesplayer.color; 
        helper t (index+1)
      end
  in 
  helper allpieces 0;
  ()

let player_list = [player_blue;player_green;player_red;player_yellow]

let update_board player coordinate board =  
  let rec helper coordinate = 
    match coordinate with
    |[]->[]
    |(x,y)::t -> board.(x).(y) <- player.color; helper t
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

let check_isvalid piece coordlst cornerlst board coordinate =
  is_valid piece coordlst cornerlst board coordinate

let check_inventory player =
  match player with
  | {inventory = inv; points = p; color = c} -> 
    match inv with
    | [] -> false
    | _ -> true

