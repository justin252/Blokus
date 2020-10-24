open OUnit2
open Player

(********************************************************************
   Here are some helper functions for your testing of set-like lists. 
 ********************************************************************)

(** [cmp_set_like_lists lst1 lst2] compares two lists to see whether
    they are equivalent set-like lists.  That means checking two things.
    First, they must both be {i set-like}, meaning that they do not
    contain any duplicates.  Second, they must contain the same elements,
    though not necessarily in the same order. *)
let cmp_set_like_lists lst1 lst2 =
  let uniq1 = List.sort_uniq compare lst1 in
  let uniq2 = List.sort_uniq compare lst2 in
  List.length lst1 = List.length uniq1
  &&
  List.length lst2 = List.length uniq2
  &&
  uniq1 = uniq2

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

(** [pp_list pp_elt lst] pretty-prints list [lst], using [pp_elt]
    to pretty-print each element of [lst]. *)
let pp_list pp_elt lst =
  let pp_elts lst =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
        if n = 100 then acc ^ "..."  (* stop printing long list *)
        else loop (n + 1) (acc ^ (pp_elt h1) ^ "; ") t'
    in loop 0 "" lst
  in "[" ^ pp_elts lst ^ "]"

(* These tests demonstrate how to use [cmp_set_like_lists] and 
   [pp_list] to get helpful output from OUnit. *)
let cmp_demo = 
  [
    "order is irrelevant" >:: (fun _ -> 
        assert_equal ~cmp:cmp_set_like_lists ~printer:(pp_list pp_string)
          ["foo"; "bar"] ["bar"; "foo"]);
    (* Uncomment this test to see what happens when a test case fails.
       "duplicates not allowed" >:: (fun _ -> 
        assert_equal ~cmp:cmp_set_like_lists ~printer:(pp_list pp_string)
          ["foo"; "foo"] ["foo"]);
    *)
  ]

(********************************************************************
   End helper functions.
 ********************************************************************)

(* You are welcome to add strings containing JSON here, and use them as the
   basis for unit tests.  Or you can add .json files in this directory and
   use them, too.  Any .json files in this directory will be included
   by [make zip] as part of your CMS submission. *)

let corners_test 
    (name : string) 
    (input: bool array array) 
    (expected_output : (int * int) list) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Player.get_all_corners input))

let is_touching_simple_test 
    (name : string) 
    (input: int*int) 
    (gameboard: game)
    (expected_output : bool) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Player.is_touching_simple input gameboard))

let placed_piece_test 
    (name : string)
    (player : Player.player) 
    (piece : Player.piece) 
    (expected_output : Player.player) : test =
  name >:: (fun _->
      assert_equal expected_output (placed_piece piece player))



let piecearray = [|[|false;false;false;false;false|];
                   [|false;false;false;false;false|];
                   [|false;false;true;false;false|];
                   [|false;false;true;false;false|];
                   [|false;true;true;true;false|]|]

let fourcorner = [|[|true;false;false;false;true|];
                   [|false;false;false;false;false|];
                   [|false;false;false;false;false|];
                   [|false;false;false;false;false|];
                   [|true;false;false;false;true|]|]

let initgameboard = [|[|'W';'W';'W';'W';'W'|];
                      [|'W';'W';'W';'W';'W'|];
                      [|'W';'W';'R';'W';'W'|];
                      [|'W';'R';'R';'W';'W'|];
                      [|'W';'W';'W';'W';'W'|]|]


let unitbool = Array.make_matrix 5 5 false 


let testboard = {gameboard = initgameboard}

let monomino_piece = [(1,1)]
let domino_piece = [(1,1); (2,1)]
let tromino_piece1 = [(1,1); (1,2); (2,1)]
let tromino_piece2 = [(1,1); (2,1); (3,1)]
let tetromino_piece1 = [(1,1); (2,1); (3,1); (4,1)]
let tetromino_piece2 = [(1,1); (2,1); (3,1); (2,2)]
let tetromino_piece3 = [(1,1); (2,1); (3,1); (3,2)]
let tetromino_piece4 = [(1,1); (2,1); (1,2); (2,2)]
let tetromino_piece5 = [(1,1); (2,1); (2,2); (3,2)]
let pentomino_piece1 = [(1,1); (2,1); (3,1); (4,1); (5,1)]

let player_tests =
  [
    (* TODO: add tests for the Adventure module here *)
    corners_test "idk" unitbool [];
    corners_test "checking" piecearray [(4,3);(4,1);(2,2)];
    corners_test "another one" fourcorner [(4, 4); (4, 0); (0, 4); (0, 0)];

    is_touching_simple_test "first" (1,3) testboard true;
    is_touching_simple_test "snd" (1,1) testboard true;
    is_touching_simple_test "third" (4,3) testboard true;
    (*is_touching_simple_test "fourth" (2,0) testboard true;*)


    placed_piece_test "Player with an inventory of just one monomino after
    placing that one piece" {inventory = [{color = "red"; shape = monomino_piece}]; 
                             color = "red"; points = 12} 
      {color = "red"; shape = monomino_piece} 
      {inventory = []; color = "red"; points = 12};
    placed_piece_test "Player with an inventory with 4 unique pieces after 
    placing one" {inventory = [{color = "blue"; shape = monomino_piece}; 
                               {color = "blue"; shape = domino_piece}; 
                               {color = "blue";  shape = tromino_piece1}; 
                               {color = "blue"; shape = tromino_piece2}]; 
                  color = "blue"; points = 24} 
      {color = "blue"; shape = tromino_piece1} 
      {inventory = [{color = "blue"; shape = monomino_piece}; 
                    {color = "blue"; shape = domino_piece}; 
                    {color = "blue"; shape = tromino_piece2}]; 
       color = "blue"; points = 24};
    placed_piece_test "Player with an inventory with 4 unique pieces after 
    placing one" {inventory = [{color = "blue"; shape = domino_piece}; 
                               {color = "blue"; shape = tetromino_piece1}; 
                               {color = "blue";  shape = tromino_piece1}; 
                               {color = "blue"; shape = tromino_piece2};
                               {color = "blue"; shape = tetromino_piece2};
                               {color = "blue"; shape = tetromino_piece3}]; 
                  color = "blue"; points = 2} 
      {color = "blue"; shape = tetromino_piece2}
      {inventory = [{color = "blue"; shape = domino_piece}; 
                    {color = "blue"; shape = tetromino_piece1}; 
                    {color = "blue";  shape = tromino_piece1}; 
                    {color = "blue"; shape = tromino_piece2};
                    {color = "blue"; shape = tetromino_piece3}]; 
       color = "blue"; points = 2};
    placed_piece_test "Player with an inventory with 4 unique pieces after 
    placing one" {inventory = [{color = "blue"; shape = domino_piece}; 
                               {color = "blue"; shape = tetromino_piece4}; 
                               {color = "blue";  shape = tromino_piece1}; 
                               {color = "blue"; shape = tromino_piece2};
                               {color = "blue"; shape = tetromino_piece5};
                               {color = "blue"; shape = tetromino_piece3};
                               {color = "blue"; shape = tetromino_piece1};
                               {color = "blue"; shape = tetromino_piece2};
                               {color = "blue"; shape = monomino_piece}
                              ]; 
                  color = "blue"; points = 18} 
      {color = "blue"; shape = monomino_piece}
      {inventory = [{color = "blue"; shape = domino_piece}; 
                    {color = "blue"; shape = tetromino_piece4}; 
                    {color = "blue";  shape = tromino_piece1}; 
                    {color = "blue"; shape = tromino_piece2};
                    {color = "blue"; shape = tetromino_piece5};
                    {color = "blue"; shape = tetromino_piece3};
                    {color = "blue"; shape = tetromino_piece1};
                    {color = "blue"; shape = tetromino_piece2}]; 
       color = "blue"; points = 18}

  ]

let suite =
  "test suite for Blokus"  >::: List.flatten [
    player_tests;
  ]

let _ = run_test_tt_main suite