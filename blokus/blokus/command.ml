(* Note: You may introduce new code anywhere in this file. *) 
open Player

type object_phrase = string list
(*type placement = int list*)
(* 
x 
x

x x

mod (# of orientations)
1 -> how it's displayed (dom: o1)
2 -> one rotation 90 degrees (dom: o2)
3 -> 180 (dom: o1)
4 -> 270 (dom: o2)


go Hoplaza

 *)

type command = 
  | Quit 
  | Continue 
  (*| Choose_piece of int
    | Orientation of int
    | Placementx of int
    | Placementy of int*)
  | Choose of int

exception Empty

exception Malformed

let parse_first str =
  let string_list= String.split_on_char ' ' str in
  let filtered_string_list= List.filter (fun x-> x <> "") string_list in
  match filtered_string_list with
  | [] -> raise Empty
  | h::t -> if h= "quit" then Quit else Continue
(* 
and parse_choose_piece choose_piece  *)

let parse_int str =
  try int_of_string str with Failure _ -> -1

and parse_after acc choose_piece orient placex placey  = 
  if choose_piece = failwith " something " then failwith "choose from inventory"
  else if orient = failwith "" then failwith "choose from 1 to 4 and else mod"
  else if placex = failwith "" && placey = failwith "" then failwith "place"

let parse str =
  let string_list= String.split_on_char ' ' str in
  let filtered_string_list= List.filter (fun x-> x <> "") string_list in
  match filtered_string_list with
  |[] -> raise Empty
  | h::t -> 
    if h = "quit" then Quit 
    else if parse_int str = -1 then Continue 
    else if parse_int str <> -1 then Choose (int_of_string str)
    else raise Malformed