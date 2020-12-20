(* Testing plan

   We have used glassbox testing to test our functions. Checking to see if each of
   our functions and it's helper functions are passing the test cases taking into
   consideration all the possible conditions for each function.

   The OUnit test cases tests the correctness of the program as it includes
   testing if the piece is removed from the player's inventory correctly by
   testing the placed_piece function and testing if the piece is added to the
   board correctly by testing place_piece function. It tests if the chosen move
   is valid by testing the main isvalid function that tests if it matches all
   the conditions for the move to be valid in addition to testing it's helper
   functions is_touching_corner that checks if the piece meets the condition of
   touching the corner of one of its pieces on the board, is_not_touching_face
   function that checks if the piece meets the condition of not touching the
   face of any of its pieces on the board, can_place_piece to check if the
   piece is not placed outside the board or on top of any existing pieces on the
   board.

   We have not tested functions like the printer functions because we tested it out
   using the make play function and seeing if it prints the desired output
   correctly at each step.

*)

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

let add_player_test
    (name : string)
    (lst1 : Player.player list)
    (lst2 : Player.player list)
    (player : Player.player)
    (expected_output : Player.player list) : test =
  name >:: (fun _-> 
      assert_equal ~cmp:cmp_set_like_lists 
        expected_output (add_player lst1 lst2 player))

let remove_player_test
    (name : string)
    (lst : Player.player list)
    (player : Player.player)
    (expected_output : Player.player list) : test =
  name >:: (fun _-> 
      assert_equal ~cmp:cmp_set_like_lists 
        expected_output (remove_player lst player))

let get_next_player_test
    (name : string)
    (lst : Player.player list)
    (player : Player.player)
    (expected_output : Player.player) : test =
  name >:: (fun _-> 
      assert_equal expected_output (get_next_player lst player))

let adjust_playerlist_test
    (name : string)
    (lst : Player.player list)
    (player : Player.player)
    (expected_output : Player.player list) : test =
  name >:: (fun _-> 
      assert_equal ~cmp:cmp_set_like_lists 
        expected_output (adjust_playerlist lst player))

let player_tests =
  [

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
      tetromino_piece1 (18,18) [(18,18); (19,18)];

    add_player_test "trying to add a player that doesn't exist in lst2" 
      [] [player_red] player_blue [];
    add_player_test "trying to add a player to an empty lst1" 
      [] [player_blue] player_blue [player_blue];
    add_player_test "trying to add a player to a non empty lst1" 
      [player_green] [player_red; player_yellow] player_yellow 
      [player_green; player_yellow];

    remove_player_test "attempts to remove a player that doesn't exist in lst1"
      [player_blue] player_green [player_blue];
    remove_player_test "attempts to remove a player from an empty list" [] 
      player_red [];
    remove_player_test "removes player from a list of players"
      [player_red; player_yellow; player_blue; player_green] player_blue
      [player_red; player_yellow; player_green];

    get_next_player_test "attempts getting next player in a list of one player"
      [player_green] player_green player_green;
    get_next_player_test "attempts getting next player in a list of two 
    players" [player_green; player_blue] player_green player_blue;
    get_next_player_test "attempts getting next player in a list of multiple 
    players" [player_red; player_yellow; player_blue; player_green] 
      player_green player_red;

    adjust_playerlist_test "adjusting a list with a player with the same 
    inventory, color, and points as one in the list" 
      [player_blue; player_green; player_red; player_yellow] player_red
      [player_blue; player_green; player_red; player_yellow];
    adjust_playerlist_test "adjusting a list with a player with different 
    inventory or points as one in the list"
      [player_blue; player_green; player_red; player_yellow]
      {inventory = [monomino; domino; tromino_p1]; 
       points = 21; 
       color = 'Y'}
      [player_blue; player_green; player_red; 
       {inventory = [monomino; domino; tromino_p1]; 
        points = 21; 
        color = 'Y'}];
    adjust_playerlist_test "adjusting a list with a player with same inventory 
    and different points as one in the list"
      [player_blue; {inventory = [domino; tromino_p1; tetromino_p5; 
                                  tetromino_p3; tetromino_p1; tetromino_p2; 
                                  monomino]; 
                     points = 14; 
                     color = 'G'}; 
       player_red; player_yellow]
      {inventory = [domino; tromino_p1; tetromino_p5; tetromino_p3; 
                    tetromino_p1; tetromino_p2; monomino]; 
       points = 3; 
       color = 'G'}
      [player_blue; {inventory = [domino; tromino_p1; tetromino_p5; 
                                  tetromino_p3; tetromino_p1; tetromino_p2; 
                                  monomino]; 
                     points = 3; 
                     color = 'G'}; 
       player_red; player_yellow];

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

let board_20x20_c = [|
  [|'B';'W';'W';'B';'W';'W';'W';'B';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'B';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'B';'W';'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'B';'W';'B';'W';'B';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'B';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'B';'W';'W';'B';'W';'W';'W';'W'|];
  [|'B';'W';'B';'W';'W';'W';'B';'W';'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'B';'W';'W';'B';'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'B';'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'B';'W';'W';'B';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
  [|'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W';'W'|];
|]


let board20x20 = [|
  [|'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*0 *)
  [|'_';'B';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*1 *)
  [|'_';'_';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*2 *)
  [|'_';'_';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*3 *)
  [|'_';'_';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*4 *)
  [|'_';'_';'_';'B';'B';'B';'B';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*5 *)
  [|'_';'_';'_';'_';'_';'_';'_';'_';'B';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*6 *)
  [|'_';'_';'_';'_';'_';'_';'_';'_';'B';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*7 *)
  [|'_';'_';'_';'_';'_';'_';'_';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*8 *)
  [|'_';'_';'_';'_';'_';'_';'_';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*9 *)
  [|'_';'_';'_';'_';'_';'_';'B';'B';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*10 *)
  [|'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*11 *)
  [|'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_'|];(*12 *)
  [|'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'R';'R';'_';'_';'_';'_';'_';'_';'_';'_'|];(*13 *)
  [|'_';'_';'_';'R';'R';'_';'_';'_';'_';'R';'R';'_';'_';'_';'_';'_';'_';'_';'G';'_'|];(*14 *)
  [|'_';'_';'_';'_';'R';'_';'_';'_';'_';'R';'_';'_';'_';'_';'_';'_';'_';'_';'G';'_'|];(*15 *)
  [|'_';'_';'_';'_';'R';'_';'_';'R';'R';'_';'_';'_';'_';'_';'_';'_';'_';'_';'G';'_'|];(*16 *)
  [|'_';'_';'_';'_';'_';'R';'R';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'G';'_'|];(*17 *)
  [|'_';'_';'_';'_';'_';'R';'R';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'G';'_'|];(*18 *)
  [|'R';'R';'R';'R';'R';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'_';'G'|];(*19 *)
|]

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

let piece_for_face1 = {color = 'R'; 
                       position_on_board = 
                         [(12, 12); (11, 13); (12,13); (12, 14)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]}

let piece_for_face2 = {color = 'Y'; 
                       position_on_board = [(0, 19)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face3 = {color = 'Y'; 
                       position_on_board = 
                         [(0, 19);(1,19);(2,19);(3,19);(4,19)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face4 = {color = 'B'; 
                       position_on_board = [(6, 10);(6,11)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face5 = {color = 'B'; 
                       position_on_board = [(6, 10); (7,10)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face6 = {color = 'R'; 
                       position_on_board = [(6, 10); (7,10)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face7 = {color = 'Y'; 
                       position_on_board = [(6, 1); (7,1);(8,1);(9,1);(10,1)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face8 = {color = 'G'; 
                       position_on_board = [(5, 0); (6,0);(7,0);(8,0);(9,0)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face9 = {color = 'G'; 
                       position_on_board = 
                         [(5, 19); (6,19);(7,19);(8,19);(9,19)]; 
                       position_on_board_corners= []; 
                       shape = [{coordinates = []; 
                                 corners = []}]} 

let piece_for_face10 = {color = 'R'; 
                        position_on_board = 
                          [(19, 7); (19,8);(19,9);(19,10);(19,11)]; 
                        position_on_board_corners= []; 
                        shape = [{coordinates = []; 
                                  corners = []}]} 

let piece_for_face11 = {color = 'Y'; 
                        position_on_board = 
                          [(0,7); (0,8);(0,9);(0,10);(0,11)]; 
                        position_on_board_corners= []; 
                        shape = [{coordinates = []; 
                                  corners = []}]} 

let piece_for_face12 = {color = 'R'; 
                        position_on_board = 
                          [(11,13); (12,12);(12,13);(12,14);(12,13)]; 
                        position_on_board_corners= []; 
                        shape = [{coordinates = []; 
                                  corners = []}]} 

let piece_for_face13 = {color = 'B'; 
                        position_on_board = 
                          [(7,11); (8,10);(8,11);(8,12);(9,11)]; 
                        position_on_board_corners= []; 
                        shape = [{coordinates = []; 
                                  corners = []}]} 

let piece_for_face14 = {color = 'G'; 
                        position_on_board = [(12,15); (12,16);(13,15);(13,16);
                                             (13,17)]; 
                        position_on_board_corners= []; 
                        shape = [{coordinates = []; 
                                  corners = []}]} 

let piece_for_face15 = {color = 'Y'; 
                        position_on_board = 
                          [(18,0); (19,0);(17,1);(18,1);(17,2)]; 
                        position_on_board_corners= []; 
                        shape = [{coordinates = []; 
                                  corners = []}]} 

let piece_for_face16 = {color = 'B'; 
                        position_on_board = 
                          [(3,2); (4,2);(4,3);(5,3);(5,4)]; 
                        position_on_board_corners= []; 
                        shape = [{coordinates = []; 
                                  corners = []}]}


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
  is_not_touching_face_test "Adding monomino to the corner: does not touch face"
    piece_for_face2 board20x20 true;
  is_not_touching_face_test "Adding pentomino to the corner: does not touch face"
    piece_for_face3 board20x20 true;
  is_not_touching_face_test 
    "Adding a piece for red player: does not touch face" piece_for_face1 
    board20x20 true;
  is_not_touching_face_test 
    "Adding domino for blue player: touches one blocks' face" piece_for_face4
    board20x20 false;
  is_not_touching_face_test 
    "Adding domino for blue player: touches two block's face" piece_for_face5
    board20x20 false;
  is_not_touching_face_test 
    "Adding domino for red player: touches two blue face: passes" piece_for_face6
    board20x20 true;
  is_not_touching_face_test 
    "Adding pentomino for yellow player: touches no corners, touches no faces" 
    piece_for_face7 board20x20 true;
  is_not_touching_face_test 
    "Checking for index out of bounds: left" piece_for_face8 board20x20 true;
  is_not_touching_face_test 
    "Checking for index out of bounds: right" piece_for_face9 board20x20 true;
  is_not_touching_face_test 
    "Checking for index out of bounds: bottom" piece_for_face10 board20x20 true;
  is_not_touching_face_test 
    "Checking for index out of bounds: top" piece_for_face11 board20x20 true;
  is_not_touching_face_test "trying out a valid game move for red player"
    piece_for_face12 board20x20 true;
  is_not_touching_face_test "trying out a valid game move for blue player"
    piece_for_face13 board20x20 true;
  is_not_touching_face_test "trying out a valid game move for green player"
    piece_for_face14 board20x20 true;
  is_not_touching_face_test "trying out a valid game move for yellow player"
    piece_for_face15 board20x20 true;
  is_not_touching_face_test "overlapping a piece and touching face"
    piece_for_face16 board20x20 false;
  is_not_touching_face_test "adding blue piece to an empty board"
    piece_for_face16 emptyboard20x20 true;
]

let is_touching_corner_test 
    (name : string) 
    (input: Player.piece) 
    (input2: Player.gameboard) 
    (expected_output : bool) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Player.check_corners input input2))

let piece1c = 
  {color = 'B'; position_on_board = [(1, 1)]; 
   position_on_board_corners= [(1, 1)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece2c = 
  {color = 'B'; position_on_board = [(1, 3)]; 
   position_on_board_corners= [(1, 3)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece3c = 
  {color = 'B'; position_on_board = [(4, 2)]; 
   position_on_board_corners= [(4, 2)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece3c = 
  {color = 'B'; position_on_board = [(4, 2)]; 
   position_on_board_corners= [(4, 2)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece4c = 
  {color = 'B'; position_on_board = [(5, 2)]; 
   position_on_board_corners= [(5, 2)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece5c = 
  {color = 'B'; position_on_board = [(6, 1)]; 
   position_on_board_corners= [(6, 1)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece6c = 
  {color = 'B'; position_on_board = [(6, 0)]; 
   position_on_board_corners= [(6, 0)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece7c = 
  {color = 'B'; position_on_board = [(8, 1)]; 
   position_on_board_corners= [(8, 1)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece8c = 
  {color = 'B'; position_on_board = [(3, 1)]; 
   position_on_board_corners= [(3, 1)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece9c = 
  {color = 'B'; position_on_board = [(1, 5); (1, 6)]; 
   position_on_board_corners= [(1, 5); (1, 6)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece10c = 
  {color = 'B'; position_on_board = [(2, 5); (2, 6)]; 
   position_on_board_corners= [(2, 5); (2, 6)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece11c = 
  {color = 'B'; position_on_board = [(3, 5); (3, 6)]; 
   position_on_board_corners= [(3, 5); (3, 6)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece12c = 
  {color = 'B'; position_on_board = [(6, 5); (6, 6)]; 
   position_on_board_corners= [(6, 5); (6, 6)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece13c = 
  {color = 'B'; position_on_board = [(8, 5); (8, 6)]; 
   position_on_board_corners= [(8, 5); (8, 6)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece14c = 
  {color = 'B'; position_on_board = [(1, 9); (1, 10)]; 
   position_on_board_corners= [(1, 9); (1, 10)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece15c = 
  {color = 'B'; position_on_board = [(2, 9); (2, 10)]; 
   position_on_board_corners= [(2, 9); (2, 10)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece16c = 
  {color = 'B'; position_on_board = [(3, 9); (3, 10)]; 
   position_on_board_corners= [(3, 9); (3, 10)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece17c = 
  {color = 'B'; position_on_board = [(6, 9); (6, 10)]; 
   position_on_board_corners= [(6, 9); (6, 10)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece18c = 
  {color = 'B'; position_on_board = [(8, 9); (8, 10)]; 
   position_on_board_corners= [(8, 9); (8, 10)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece18c = 
  {color = 'B'; position_on_board = [(8, 9); (8, 10)]; 
   position_on_board_corners= [(8, 9); (8, 10)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece19c = 
  {color = 'B'; position_on_board = [(1, 13); (2, 13)]; 
   position_on_board_corners= [(1, 13); (2, 13)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece20c = 
  {color = 'B'; position_on_board = [(1, 14); (2, 14)]; 
   position_on_board_corners= [(1, 14); (2, 14)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece21c = 
  {color = 'B'; position_on_board = [(1, 15); (2, 15)]; 
   position_on_board_corners= [(1, 15); (2, 15)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece22c = 
  {color = 'B'; position_on_board = [(5, 13); (6, 13)]; 
   position_on_board_corners= [(5, 13); (6, 13)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece23c = 
  {color = 'B'; position_on_board = [(5, 14); (6, 14)]; 
   position_on_board_corners= [(5, 14); (6, 14)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece24c = 
  {color = 'B'; position_on_board = [(10, 0); (11, 0)]; 
   position_on_board_corners= [(10, 0); (11, 0)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece25c = 
  {color = 'B'; position_on_board = [(11, 1); (12, 1)]; 
   position_on_board_corners= [(11, 1); (12, 1)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece26c = 
  {color = 'B'; position_on_board = [(11, 3); (12, 3)]; 
   position_on_board_corners= [(11, 3); (12, 3)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece27c = 
  {color = 'B'; position_on_board = [(13, 1); (14, 1)]; 
   position_on_board_corners= [(13, 1); (14, 1)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece28c = 
  {color = 'B'; position_on_board = [(13, 2); (14, 2)]; 
   position_on_board_corners= [(13, 2); (14, 2)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece29c = 
  {color = 'B'; position_on_board = [(11, 6); (11, 5); (11, 7); (10, 6); (12, 6)]; 
   position_on_board_corners= [(11, 5); (11, 7); (10, 6); (12, 6)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece30c = 
  {color = 'B'; position_on_board = [(10, 9); (10, 10); (12, 9); (12, 10); (11, 10)]; 
   position_on_board_corners= [(10, 9); (10, 10); (12, 9); (12, 10)]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }
let piece31c = 
  {color = 'B'; position_on_board = [(10, 13); (12, 13); (12, 14); (11, 14); (11, 13)]; 
   position_on_board_corners= [(10, 13); (12, 13); (12, 14); (11, 14);]; 
   shape = [{coordinates = []; 
             corners = []
            }]
  }

let corner_tests =[
  is_touching_corner_test "has none, touch TL" piece1c board_20x20_c true;
  is_touching_corner_test "has none, touch T" piece2c board_20x20_c false;
  is_touching_corner_test "has none, touch TR" piece3c board_20x20_c true;
  is_touching_corner_test "has none, touch R" piece4c board_20x20_c false;
  is_touching_corner_test "has none, touch BR" piece5c board_20x20_c true;
  is_touching_corner_test "has none, touch B" piece6c board_20x20_c false;
  is_touching_corner_test "has none, touch BL" piece7c board_20x20_c true;
  is_touching_corner_test "has none, touch L" piece8c board_20x20_c false;

  is_touching_corner_test "has left, touch TR, BR" piece9c board_20x20_c true;
  is_touching_corner_test "has left, touch R" piece10c board_20x20_c false;
  is_touching_corner_test "has left, touch BR, TR" piece11c board_20x20_c true;
  is_touching_corner_test "has left, touch B" piece12c board_20x20_c false;
  is_touching_corner_test "has left, touch T" piece13c board_20x20_c false;

  is_touching_corner_test "has right, touch TL, BL" piece14c board_20x20_c true;
  is_touching_corner_test "has right, touch L" piece15c board_20x20_c false;
  is_touching_corner_test "has right, touch BL, TL" piece16c board_20x20_c true;
  is_touching_corner_test "has right, touch B" piece17c board_20x20_c false;
  is_touching_corner_test "has right, touch T" piece18c board_20x20_c false;

  is_touching_corner_test "has bot, touch BL, BR" piece19c board_20x20_c true;
  is_touching_corner_test "has bot, touch B" piece20c board_20x20_c false;
  is_touching_corner_test "has bot, touch BR, BL" piece21c board_20x20_c true;
  is_touching_corner_test "has bot, touch L" piece22c board_20x20_c false;
  is_touching_corner_test "has bot, touch R" piece23c board_20x20_c false;

  is_touching_corner_test "has top, touch T" piece24c board_20x20_c false;
  is_touching_corner_test "has bot, touch TR" piece25c board_20x20_c true;
  is_touching_corner_test "has bot, touch TL" piece26c board_20x20_c true;
  is_touching_corner_test "has bot, touch L" piece27c board_20x20_c false;
  is_touching_corner_test "has bot, touch R" piece28c board_20x20_c false;

  is_touching_corner_test "has BTRL, 4 spots, " piece29c board_20x20_c false;

  is_touching_corner_test "5 blocks engulf 1, " piece30c board_20x20_c false;
  is_touching_corner_test "pent7 touches nothing" piece31c board_20x20_c false;

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

  is_valid_test "placing initial at wrong coord" piece12 lst1 lst2 
    newemptyboard (1,1) false;
  is_valid_test "emptyboard 10x10 placing initial correctly" piece12 lst1 lst2 
    newemptyboard (0,0) true;
  is_valid_test "placing initial incorrectly" piece12 lst1 lst2 
    newemptyboard (1,2) false;
  is_valid_test "placing initial in middle" piece12 lst1 lst2 
    newemptyboard (5,5) false;
  is_valid_test "emptyboard 20x20 placing initial correctly" piece12 lst1 lst2 
    emptyboard20x20 (0,0) true;



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

let update_board_test
    (name : string)  
    (input1: Player.player) 
    (input2: (int*int) list)
    (input3: Player.gameboard)
    (expected_output : Player.gameboard) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Game.update_board input1 input2 input3))


let emptybrdforupdating = [|
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
|]

let boardafter1st = [|
  [|'B';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
|]


let boardafter2nd = [|
  [|'B';'B';'B';'B';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
|]

let emptybrdforrandom = [|
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
|]

let randomplaceboard = [|
  [|'B';'B';'-';'-';'-';'-';'-';'-'|];
  [|'-';'B';'B';'-';'-';'-';'-';'-'|];
  [|'-';'-';'B';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
  [|'-';'-';'-';'-';'-';'-';'-';'-'|];
|]

let board_tests = [
  update_board_test "testing corner placement" player_blue [0,0] 
    emptybrdforupdating boardafter1st;
  update_board_test "testing long piece placement" player_blue 
    [(0,0);(0,1);(0,2);(0,3)] emptybrdforupdating boardafter2nd;
  update_board_test "testing random placement" player_blue 
    [(0,0);(0,1);(1,1);(1,2);(2,2)] emptybrdforrandom randomplaceboard;
]


let suite = 
  "test suite"  >::: List.flatten [
    corner_tests;
    face_tests;
    player_tests;
    is_valid_several_tests;
    can_place_tests;

    print_tests;
    board_tests;

  ]
let _ = run_test_tt_main suite