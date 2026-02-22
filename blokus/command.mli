type command =
  | Quit
  | Continue
  | Choose of int

(** Result type replaces exceptions for parse outcomes *)
type parse_result = Ok of command | Empty_input | Bad_input

val parse : string -> parse_result

val parse_int : string -> int option
