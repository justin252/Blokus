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
      print_string piece.(i).(j)
    done
  done


let piece_to_piecearray piece = 
  let matrix = Array.make_matrix 5 5 " " in
  let rec helper piece =
    match piece with
    |[]->[]
    |(x,y)::t -> matrix.(x).(y) <- "X"; helper t
  in
  helper piece;
  matrix

let print_individual_piece indpiece = 
  let orien = indpiece.shape in
  let get_first orien = 
    match orien with
    |[]->None
    |h::t -> Some h
  in
  let matrixofpiece =  piece_to_piecearray (List.hd orien).coordinates in
  piece_printer matrixofpiece


let print_pieces piecesplayer = 
  let allpieces = piecesplayer.inventory in
  let rec helper allpieces = 
    match allpieces with
    |[] -> []
    |h::t -> print_individual_piece h; helper t
  in 
  helper allpieces;
  ()

let update_board board = 
  failwith "unimplemented"

let print_orientation piece = 
  failwith "unimplemented"

