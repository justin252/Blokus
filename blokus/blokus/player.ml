type piece={
  color: string;
  shape: bool array array;
}

type player={
  inventory: piece array; 
  total_points: int; 
  color: string;
}

let valid_moves (player_piece: piece ) : piece array = 
  failwith "Unimplemented"

let is_eliminated player1 player_piece = 
  let pieces= valid_moves player_piece in
  if Array.length pieces= 0 then true
  else false

let is_touching player = 
  failwith "Unimplemented"


