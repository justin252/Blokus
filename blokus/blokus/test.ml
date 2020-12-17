open OUnit2
open Player
open Game

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

(*let corners_test 
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
      assert_equal expected_output (Player.is_touching_simple input gameboard))*)

let placed_piece_test 
    (name : string)
    (player : Player.player) 
    (piece : Player.piece) 
    (expected_output : Player.player) : test =
  name >:: (fun _->
      assert_equal expected_output (placed_piece piece player))

let place_piece_test 
    (name : string)
    (piece : (int * int) list) 
    (coordinate : (int * int)) 
    (expected_output : (int * int) list) : test =
  name >:: (fun _->
      assert_equal expected_output (place_piece piece coordinate))

let monomino_o1 = [(0,0)]
let monomino_o1_corners = [(0,0)]
let monomino = 
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = [{coordinates = monomino_o1; 
             corners = monomino_o1_corners}]}

let domino_o1 = [(0,0); (0,1)]
let domino_o1_corners = [(0,0); (0,1)]
let domino_o2 = [(0,0); (1,0)]
let domino_o2_corners = [(0,0); (1,0)]
let domino = 
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = [{coordinates = domino_o1; 
             corners = domino_o1_corners}; 
            {coordinates = domino_o2; 
             corners = domino_o2_corners}]}

let tromino_p1_o1 = [(0,0); (0,1); (1,1)]
let tromino_p1_o1_corners = [(0,0); (0,1); (1,1)]
let tromino_p1_o2 = [(0,1); (1,0); (1,1)]
let tromino_p1_o2_corners = [(0,1); (1,0); (1,1)]
let tromino_p1_o3 = [(0,0); (1,0); (1,1)]
let tromino_p1_o3_corners = [(0,0); (1,0); (1,1)]
let tromino_p1_o4 = [(0,0); (0,1); (1,0)]
let tromino_p1_o4_corners = [(0,0); (0,1); (1,0)]
let tromino_p1 = 
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = [{coordinates = tromino_p1_o1; 
             corners = tromino_p1_o1_corners};
            {coordinates = tromino_p1_o2;
             corners = tromino_p1_o2_corners}; 
            {coordinates = tromino_p1_o3; 
             corners = tromino_p1_o3_corners};
            {coordinates = tromino_p1_o4; 
             corners = tromino_p1_o4_corners}]}

let tromino_p2_o1 = [(0,0); (0,1); (0,2)]
let tromino_p2_o1_corners = [(0,0); (0,2)]
let tromino_p2_o2 = [(0,0); (1,0); (2,0)]
let tromino_p2_o2_corners = [(0,0); (2,0)]
let tromino_p2 = 
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = 
     [{coordinates = tromino_p2_o1; 
       corners = tromino_p2_o1_corners};
      {coordinates = tromino_p2_o2; 
       corners = tromino_p2_o2_corners}]}

let tetromino_p1_o1 = [(0,0); (0,1); (1,0); (1,1)]
let tetromino_p1_o1_corners = [(0,0); (0,1); (1,0); (1,1)]
let tetromino_p1 =
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = 
     [{coordinates = tetromino_p1_o1; 
       corners = tetromino_p1_o1_corners}]}

let tetromino_p2_o1 = [(0,1); (1,0); (1,1); (1,2)]
let tetromino_p2_o1_corners = [(0,1); (1,0); (1,2)]
let tetromino_p2_o2 = [(0,0); (1,0); (1,1); (2,0)]
let tetromino_p2_o2_corners = [(0,0); (1,1); (2,0)]
let tetromino_p2_o3 = [(0,0); (0,1); (0,2); (1,1)]
let tetromino_p2_o3_corners = [(0,0); (0,2); (1,1)]
let tetromino_p2_o4 = [(0,1); (1,0); (1,1); (2,1)]
let tetromino_p2_o4_corners = [(0,1); (1,0); (2,1)]
let tetromino_p2 =
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = 
     [{coordinates = tetromino_p2_o1; 
       corners = tetromino_p2_o1_corners};
      {coordinates = tetromino_p2_o2; 
       corners = tetromino_p2_o2_corners}; 
      {coordinates = tetromino_p2_o3; 
       corners = tetromino_p2_o3_corners};
      {coordinates = tetromino_p2_o4; 
       corners = tetromino_p2_o4_corners}]}

let tetromino_p3_o1 = [(0,0); (0,1); (0,2); (0,3)]
let tetromino_p3_o1_corners = [(0,0); (0,3)]
let tetromino_p3_o2 = [(0,0); (1,0); (2,0); (3,0)]
let tetromino_p3_o2_corners = [(0,0); (3,0)]
let tetromino_p3 =
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = 
     [{coordinates = tetromino_p3_o1; 
       corners = tetromino_p3_o1_corners};
      {coordinates = tetromino_p3_o2; 
       corners = tetromino_p3_o2_corners}]}

let tetromino_p4_o1 = [(0,2); (1,0); (1,1); (1,2)]
let tetromino_p4_o1_corners = [(0,2); (1,0); (1,2);]
let tetromino_p4_o2 = [(0,0); (1,0); (2,0); (2,1)]
let tetromino_p4_o2_corners = [(0,0); (2,0); (2,1)]
let tetromino_p4_o3 = [(0,0); (0,1); (0,2); (1,0)]
let tetromino_p4_o3_corners = [(0,0); (0,2); (1,0)]
let tetromino_p4_o4 = [(0,0); (0,1); (1,1); (2,1)]
let tetromino_p4_o4_corners = [(0,0); (0,1); (2,1)]
let tetromino_p4 =
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = 
     [{coordinates = tetromino_p4_o1; 
       corners = tetromino_p4_o1_corners};
      {coordinates = tetromino_p4_o2; 
       corners = tetromino_p4_o2_corners}; 
      {coordinates = tetromino_p4_o3; 
       corners = tetromino_p4_o3_corners};
      {coordinates = tetromino_p4_o4; 
       corners = tetromino_p4_o4_corners}]}

let tetromino_p5_o1 = [(0,1); (0,2); (1,0); (1,1)]
let tetromino_p5_o1_corners = [(0,1); (0,2); (1,0); (1,1)]
let tetromino_p5_o2 = [(0,0); (1,0); (1,1); (2,1)]
let tetromino_p5_o2_corners = [(0,0); (1,0); (1,1); (2,1)]
let tetromino_p5 =
  {color = 'W'; 
   position_on_board = []; 
   position_on_board_corners = [];
   shape = 
     [{coordinates = tetromino_p5_o1; 
       corners = tetromino_p5_o1_corners};
      {coordinates = tetromino_p5_o2; 
       corners = tetromino_p5_o2_corners};]}


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
    (*corners_test "idk" unitbool [];
      corners_test "checking" piecearray [(4,3);(4,1);(2,2)];
      corners_test "another one" fourcorner [(4, 4); (4, 0); (0, 4); (0, 0)];
      is_touching_simple_test "first" (1,3) testboard true;
      is_touching_simple_test "snd" (1,1) testboard true;
      is_touching_simple_test "third" (4,3) testboard true;
      (*is_touching_simple_test "fourth" (2,0) testboard true;*)
    *)

    placed_piece_test "Player with an inventory of just 1 monomino after
      placing that one piece" {inventory = [monomino]; 
                               points = 12; 
                               color = 'R'} 
      monomino {inventory = []; 
                points = 12; 
                color = 'R'};
    placed_piece_test "Player with an inventory with 4 unique pieces after 
      placing one" {inventory = [monomino; domino; tromino_p1; tromino_p2]; 
                    points = 24; 
                    color = 'B'} 
      tromino_p1 {inventory = [monomino; domino; tromino_p2]; 
                  points = 24; 
                  color = 'B'};
    placed_piece_test "Player with an inventory with 6 unique pieces after 
      placing one" {inventory = [domino; tetromino_p1; tromino_p1; tromino_p2; 
                                 tetromino_p2; tetromino_p3]; 
                    points = 2; 
                    color = 'B'} 
      tetromino_p2 {inventory = [domino; tetromino_p1; tromino_p1; tromino_p2; 
                                 tetromino_p3]; 
                    points = 2; 
                    color = 'B'};
    placed_piece_test "Player with an inventory with 9 unique pieces after 
      placing one" {inventory = [domino; tetromino_p4; tromino_p1; tromino_p2;
                                 tetromino_p5; tetromino_p3; tetromino_p1; 
                                 tetromino_p2; monomino]; 
                    points = 15; 
                    color = 'G'} 
      monomino {inventory = [domino; tetromino_p4; tromino_p1; tromino_p2;
                             tetromino_p5; tetromino_p3; tetromino_p1; 
                             tetromino_p2]; 
                points = 15; 
                color = 'G'};
    placed_piece_test "Player with an inventory with 7 unique pieces after 
      placing one" {inventory = [tromino_p1; tromino_p2;
                                 tetromino_p5; tetromino_p3; tetromino_p1; 
                                 tetromino_p2; monomino]; 
                    points = 50; 
                    color = 'Y'} 
      tetromino_p3 {inventory = [tromino_p1; tromino_p2; tetromino_p5; 
                                 tetromino_p1; tetromino_p2; monomino]; 
                    points = 50; 
                    color = 'Y'};
    placed_piece_test "Player with an inventory with 5 unique pieces after 
      placing one" {inventory = [tromino_p1; tromino_p2; tetromino_p3; 
                                 tetromino_p1; monomino]; 
                    points = 10; 
                    color = 'R'} 
      tetromino_p1 {inventory = [tromino_p1; tromino_p2; 
                                 tetromino_p3;  monomino]; 
                    points = 10; 
                    color = 'R'};
    placed_piece_test "Player with an inventory with 3 unique pieces after 
      placing one" {inventory = [monomino; domino; tromino_p1]; 
                    points = 21; 
                    color = 'Y'} 
      domino {inventory = [monomino; tromino_p1]; 
              points = 21; 
              color = 'Y'};
    placed_piece_test "Player with an inventory with 8 unique pieces after 
      placing one" {inventory = [domino; tetromino_p4; tromino_p1;
                                 tetromino_p5; tetromino_p3; tetromino_p1; 
                                 tetromino_p2; monomino]; 
                    points = 14; 
                    color = 'G'} 
      tetromino_p4 {inventory = [domino; tromino_p1; 
                                 tetromino_p5; tetromino_p3; tetromino_p1; 
                                 tetromino_p2; monomino]; 
                    points = 14; 
                    color = 'G'};

    place_piece_test "Testing mono" 
      monomino_piece (14,14) [(14,14)];
    place_piece_test "Testing dom" 
      domino_piece (14,14) [(14,14);(15,14)];
    place_piece_test "Testing tro" 
      tromino_piece1 (14,14) [(14,14);(14,15);(15,14)];
    place_piece_test "Testing dom bad" 
      domino_piece (19,19) [(19,19)];
    place_piece_test "Testing tetr" 
      tetromino_piece1 (18,18) [(18,18); (19,18)]



  ]

(********************************************************************
   Hard-coded board 
 ********************************************************************)


let emptyboard = [|
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|]
|]

let newemptyboard = [|
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
|]

let board1 = [|
  [|'R';'R';'W';'W';'W';'W';'W';'W'|];
  [|'R';'R';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|]
|]

let board2 = [|
  [|'R';'R';'W';'W';'W';'W';'W';'W'|];
  [|'R';'R';'R';'W';'W';'W';'W';'W'|];
  [|'W';'R';'R';'W';'W';'W';'W';'W'|];
  [|'W';'W';'R';'W';'W';'W';'W';'W'|];
  [|'W';'W';'x';'W';'W';'W';'W';'W'|];
  [|'W';'W';'x';'x';'x';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|]
|]

let board_edge = [|
  [|'R';'R';'W';'R';'R';'x';'W';'W'|];
  [|'R';'R';'R';'W';'R';'x';'W';'W'|];
  [|'W';'R';'R';'W';'W';'x';'W';'W'|];
  [|'x';'x';'W';'W';'W';'W';'W';'W'|];
  [|'x';'x';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W'|]
|]
let board5x5 = [|
  [|'R';'x';'R';'W';'W'|];
  [|'W';'x';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W'|]
|]

let board20x20 = [|
  [|'B';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'B';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
|]

let emptyboard20x20 = [|
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-';'-'|];
|]


let filled20x20 = [|
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
|]

(* 
has_left = true
has_bottom = true
has_top = false
has_right = false
*)
let piece1 = {color = 'R'; 
              position_on_board = [(2, 2); (3, 2)]; 
              position_on_board_corners= [(2, 2); (3, 2)]; 
              shape = [{coordinates = []; 
                        corners = []}]}
let piece2 = {color = 'R'; 
              position_on_board = [(3, 0); (4, 0); (5, 0); (5,1)]; 
              position_on_board_corners= [(3, 0); (5, 0); (5,1)]; 
              shape = [{coordinates = []; 
                        corners = []}]}
let piece3 = {color = 'R'; 
              position_on_board = [(4, 2); (5, 2); (5, 3); (5,4)]; 
              position_on_board_corners= [(4, 2); (5, 2); (5, 4)]; 
              shape = [{coordinates = []; 
                        corners = []}]}
let piece4 = {color = 'R'; 
              position_on_board = [(3, 0); (4, 0); (4, 1); (4,2)]; 
              position_on_board_corners= [(3, 0); (4, 0); (4,2)]; 
              shape = [{coordinates = []; 
                        corners = []}]}
let piece5= {color = 'R'; 
             position_on_board = [(7, 7); (7, 6); (6, 7); (5,7)]; 
             position_on_board_corners= [(7, 7); (7, 6); (5,7)]; 
             shape = [{coordinates = []; 
                       corners = []}]}
let piece_top = {color = 'R'; 
                 position_on_board = [(0, 5); (1, 5); (2,5)]; 
                 position_on_board_corners= [(0, 5); (2, 5)]; 
                 shape = [{coordinates = []; 
                           corners = []}]}
let piece6= {color = 'R'; 
             position_on_board = [(6, 0); (7, 0); (6, 1); (7,1)]; 
             position_on_board_corners= [(6, 0); (7, 0); (6, 1); (7,1)]; 
             shape = [{coordinates = []; 
                       corners = []}]}
let piece7= {color = 'R'; 
             position_on_board = [(3, 0); (3, 1); (4, 0); (4,1)]; 
             position_on_board_corners= [(3, 0); (3, 1); (4, 0); (4,1)]; 
             shape = [{coordinates = []; 
                       corners = []}]}

let piece5x5 = {color = 'R'; 
                position_on_board = [(0, 1); (1, 1)]; 
                position_on_board_corners = [(0, 1); (1, 1)]; 
                shape = [{coordinates = []; 
                          corners = []}]}

let is_touching_corner_test 
    (name : string) 
    (input: Player.piece) 
    (input2: Player.gameboard) 
    (expected_output : bool) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Player.check_corners input input2))

let corner_tests =[
  is_touching_corner_test "empty corner" piece1 emptyboard false;
  is_touching_corner_test "Generic test" piece1 board1 true;
  is_touching_corner_test "Generic test 2" piece2 board2 true;
  is_touching_corner_test "Not touching, box piece" piece3 board2 false; 
  is_touching_corner_test "left edge" piece4 board_edge true;
  is_touching_corner_test "right corner edge" piece5 board_edge false;
  is_touching_corner_test "left corner edge" piece6 board_edge false;
  is_touching_corner_test "passes touching corner but fails touching face" 
    piece7 board_edge true;
  (* is_touching_corner_test "touch_corner also checks touching edge" piece5x5 board5x5 true; *)
]

let is_not_touching_face_test
    (name : string) 
    (input: Player.piece) 
    (input2: Player.gameboard) 
    (expected_output : bool) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Player.check_faces input input2))

let face_tests =[
  is_not_touching_face_test "empty face" piece1 emptyboard true; 
  is_not_touching_face_test "top edge" piece_top board_edge false; 
  is_not_touching_face_test "Generic test" piece1 board1 true;
  is_not_touching_face_test "Generic test 2" piece2 board2 true;
  is_not_touching_face_test "Not touching, box piece" piece3 board2 false;  
  is_not_touching_face_test "left edge" piece4 board_edge true;
  is_not_touching_face_test "right corner edge" piece5 board_edge true;
  is_not_touching_face_test "left corner edge" piece6 board_edge true;
  is_not_touching_face_test "passes touching corner but fails touching face"
    piece7 board_edge false;
  is_not_touching_face_test "corner touches but block above it touches face" 
    piece5x5 board5x5 false;

]

let piece12 = {color = 'R'; 
               position_on_board = []; 
               position_on_board_corners= []; 
               shape = [{coordinates = []; corners = []}]}
let piece22 = {color = 'R'; 
               position_on_board = []; 
               position_on_board_corners= []; 
               shape = [{coordinates = []; corners = []}]}

let lst1 = [(2, 2); (3, 2)]
let lst2 = [(2, 2); (3, 2)]

let lst3 = [(3, 0); (4, 0); (5, 0); (5,1)]
let lst4 = [(3, 0); (5, 0); (5,1)]

let is_valid_test 
    (name : string)
    (input1: Player.piece) 
    (input2: (int * int) list) 
    (input3: (int * int) list)
    (input4: Player.gameboard)
    (input5: int * int) 
    (expected_output : bool) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output 
        (Player.is_valid input1 input2 input3 input4 input5))

let is_valid_several_tests = [

  is_valid_test "emptyboard1" piece12 lst1 lst2 newemptyboard (1,1) false;
  is_valid_test "emptyboard 10x10" piece12 lst1 lst2 newemptyboard (0,0) true;
  is_valid_test "emptyboard3" piece12 lst1 lst2 newemptyboard (1,2) false;
  is_valid_test "emptyboard4" piece12 lst1 lst2 newemptyboard (5,5) false;
  is_valid_test "emptyboard 20x20" piece12 lst1 lst2 emptyboard20x20 (0,0) 
    true;



  is_valid_test "yo" piece12 lst1 lst2 board1 (2,2) false;
  is_valid_test "yeet" piece12 lst1 lst2 board1 (5,5) false;
  is_valid_test "ya" piece22 lst3 lst4 emptyboard (3,0) false;
  is_valid_test "yun" piece12 lst1 lst2 board1 (1,1) false;
  is_valid_test "yup" piece12 lst1 lst2 board1 (5,5) false;


] 

let can_place_piece_test 
    (name : string)
    (input1: Player.piece) 
    (input2: Player.gameboard)
    (expected_output : bool) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output 
        (Player.can_place_piece input1 input2))

let can_place_tests = [

  can_place_piece_test "can 1" piece1 newemptyboard true;
  can_place_piece_test "can 2" piece2 newemptyboard true;
  can_place_piece_test "can 3" piece3 newemptyboard true;
  can_place_piece_test "can 4" piece1 board2 false;
  can_place_piece_test "can 5" piece1 board2 false;

] 

let print_board_test
    (name : string)  
    (input: Player.gameboard) 
    (expected_output : unit) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Game.print_board input))

let print_pieces_test
    (name : string)  
    (input: Player.player) 
    (expected_output : unit) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Game.print_pieces input))

let print_tests = [
  print_board_test "" board1 ();
  print_board_test "" board2 ();

  print_pieces_test "" Player.player_yellow ();

] 


let suite = 
  "test suite"  >::: List.flatten [
    corner_tests;
    face_tests;
    player_tests;
    is_valid_several_tests;
    can_place_tests;

    print_tests;

  ]
let _ = run_test_tt_main suite