open Player

(** Map color variant to ANSITerminal style *)
let ansi_style_of_color = function
  | Blue -> ANSITerminal.[blue]
  | Green -> ANSITerminal.[green]
  | Red -> ANSITerminal.[red]
  | Yellow -> ANSITerminal.[yellow]

(** Print a single cell — shared by print_board and piece_printer *)
let print_cell = function
  | Some c ->
    ANSITerminal.(print_string (ansi_style_of_color c)
      (String.make 1 (char_of_color c)))
  | None -> print_char '_'

let print_board (board : gameboard) =
  Array.iteri (fun _ row ->
    print_newline ();
    Array.iteri (fun _ cell ->
      print_cell cell;
      print_char ' '
    ) row
  ) board

(** Print piece preview array — pattern match on color option *)
let piece_printer piece =
  Array.iteri (fun _ row ->
    print_newline ();
    Array.iteri (fun _ cell ->
      match cell with
      | Some c ->
        ANSITerminal.(print_string (ansi_style_of_color c)
          (String.make 1 (char_of_color c)))
      | None -> ()
    ) row
  ) piece

(** Build 5x5 preview matrix using Array.init + List.mem *)
let piece_to_piecearray coords color =
  Array.init 5 (fun r ->
    Array.init 5 (fun c ->
      if List.mem (r, c) coords then Some color else None
    )
  )

let print_individual_piece indpiece color =
  let coords = (List.hd indpiece.shape).coordinates in
  piece_printer (piece_to_piecearray coords color)

let print_pieces player =
  List.iteri (fun i piece ->
    print_newline ();
    print_string ("Piece: " ^ string_of_int i);
    print_individual_piece piece player.color
  ) player.inventory

let player_list = [player_blue; player_green; player_red; player_yellow]

(** Copy-on-write board update — returns new board, original untouched *)
let update_board player cells (board : gameboard) =
  Array.init (Array.length board) (fun r ->
    let row = Array.copy board.(r) in
    List.iter (fun (pr, pc) ->
      if pr = r then row.(pc) <- Some player.color
    ) cells;
    row
  )

(** Orientation display uses List.mapi for clean char list rendering *)
let fill_in_base coords color =
  List.init 5 (fun r ->
    List.init 5 (fun c ->
      if List.mem (r, c) coords then char_of_color color else ' '
    )
  )

let print_char_list lst =
  let string_of_char_list l =
    String.concat " " (List.map Char.escaped l) in
  let char_list_to_string l =
    String.concat "\n" (List.map string_of_char_list l) in
  Printf.printf "%s" (char_list_to_string lst)

let print_orientation (piece : piece) =
  List.iteri (fun num orient ->
    print_string ("Orientation " ^ string_of_int num);
    print_newline ();
    print_char_list (fill_in_base orient.coordinates piece.color);
    print_newline ()
  ) piece.shape

(** Pattern match on color variant — replaces if/else chain *)
let match_color color s =
  let name = match color with
    | Red -> "Red" | Yellow -> "Yellow"
    | Green -> "Green" | Blue -> "Blue"
  in
  ANSITerminal.(print_string (ansi_style_of_color color)
    (name ^ " Player: " ^ string_of_int s))

let print_scores playerlst =
  List.iter (fun p ->
    print_newline ();
    match_color p.color (score p)
  ) playerlst;
  print_newline ()
