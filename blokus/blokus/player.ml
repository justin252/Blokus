type orientation={
  coordinates: (int * int) list;
  corners: (int * int) list
}

type piece = {
  color : string;
  mutable position_on_board: (int * int) list;
  mutable position_on_board_corners: (int * int) list;
  shape : orientation list
}

type game = {
  gameboard: char array array
}

type player={
  inventory: piece list; 
  points : int;
  color: string;
}



(** same_orientation returns true if two pieces, [piece1] and [piece2] are the 
    same piece with either the same exact orientation or a different orientation 
    or returns false otherwise, i.e. two unique/distinct pieces.*)
let rec same_orientation piece1 piece2 e =
  match piece1 with
  | [] -> true
  | h :: t -> 
    match piece2 with
    | [] -> true
    | a :: b ->
      if (h = a) then (
        same_orientation t b e
      ) else (
        false
      )

let return_inventory player =
  player.inventory

let rec placed_piece_helper inv piece =
  match inv with
  | [] -> failwith "Piece not in Inventory"
  | h :: t ->
    if (h = piece) then (
      t
    ) else (
      [h] @ placed_piece_helper t piece
    )

(** [placed_piece] returns the [player] with his/her inventory modified after
    removing the placed [piece] for their inventory. *)
let placed_piece piece player =
  {inventory = placed_piece_helper player.inventory piece; color = player.color; points = player.points}

let is_eliminated player = 
  if player.inventory = [] then true else false

(*let rec corner_place_algo piece coordinate = 
  match piece with
  |[]->[]
  |(x,y)::t -> ((x - (fst coordinate)), (y - (snd coordinate))):: (corner_place_algo t coordinate)*)

(*let rec place_algo piece coordinate = 
  match piece with
  |[]->[]
  |(x,y)::t -> ((x - (fst coordinate)), (y - (snd coordinate))):: (place_algo t coordinate)*)

let rec corner_place_algo piece coordinate = 
  match piece with
  |[]->[]
  |(x,y)::t -> if (x + (fst coordinate)) < 20 && (y + (snd coordinate)) < 20 && (x + (fst coordinate)) >= 0 && (y + (snd coordinate)) >= 0
    then ((x + (fst coordinate)), (y + (snd coordinate)))::(corner_place_algo t coordinate) 
    else []

let rec place_algo piece coordinate = 
  match piece with
  |[]->[]
  |(x,y)::t -> if (x + (fst coordinate)) < 20 && (y + (snd coordinate)) < 20 && (x + (fst coordinate)) >= 0 && (y + (snd coordinate)) >= 0 
    then ((x + (fst coordinate)), (y + (snd coordinate)))::(place_algo t coordinate) 
    else []

let get_head piece =
  match piece with
  |[]->(0,0)
  |(x,y)::t -> (x,y)

let get_tail piece = 
  match piece with
  |[]->[]
  |(x,y)::t -> t

let rec subtract_from_init piece head = 
  match piece with
  |[]->[]
  |(x,y)::t -> ((x - fst head), (y -snd head)) :: subtract_from_init t head

(* update position on board list*)
let place_piece piece coordinate =
  let head = get_head piece in
  let list_to_board = subtract_from_init piece head in
  place_algo list_to_board coordinate

let place_piece_corner piece coordinate =
  let head = get_head piece in
  let list_to_board = subtract_from_init piece head in
  corner_place_algo list_to_board coordinate

(*let place_piece_corner piece coordinate =
  match piece with
  |[]->[]
  |h::t -> coordinate :: (place_algo t coordinate)*)

let rec check_board piece board = 
  match piece with 
  | [] -> true
  |(x,y)::t -> if board.(x).(y) = 'W' then check_board t board else false

let update_pos_on_board piece lst coordinate = 
  let posonboard = place_piece lst coordinate in
  let check_cond = if List.length posonboard = List.length lst then true else false in
  if check_cond = true then piece.position_on_board <- posonboard else piece.position_on_board <- []

let update_corn_on_board piece lst coordinate = 
  let cornonbord = place_piece_corner lst coordinate in
  let check_cond = if List.length cornonbord = List.length lst then true else false in
  if check_cond = true then piece.position_on_board_corners <- cornonbord else piece.position_on_board_corners <- []

(** see if we can actually place piece*)
let can_place_piece piece board coordinate =
  if piece.position_on_board = [] then false else check_board piece.position_on_board board

let check_corners piece board = 
  failwith "unimplemented"

let check_faces piece board =
  failwith "unimplemented"

let is_touching piece board =
  failwith "unimplemented"

let is_valid piece coordlst cornerlst board coordinate = 
  update_pos_on_board piece coordlst coordinate;
  update_corn_on_board piece cornerlst coordinate;
  if can_place_piece piece board coordinate && is_touching piece board then true else false



