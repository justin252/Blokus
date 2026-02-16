type command =
  | Quit
  | Continue
  | Choose of int

(** Result type — Option/Result over exceptions *)
type parse_result = Ok of command | Empty_input | Bad_input

let parse_int str = int_of_string_opt str

let parse str =
  let words = String.split_on_char ' ' str |> List.filter (fun x -> x <> "") in
  match words with
  | [] -> Empty_input
  | h :: _ ->
    if h = "quit" then Ok Quit
    else match int_of_string_opt str with
      | Some n -> Ok (Choose n)
      | None -> Ok Continue
