type piece={
  color: string;
  orientation: string; (* unsure about how we would implement this *)
  shape: bool array;
}

type player={
  remaining_pieces: piece array; (* do we wanna do list or array? *)
  total_points: int; (* do we want a function that calculates the score too? *)
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


