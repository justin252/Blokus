open OUnit2
open Player

(* --- Pretty printers for test output --- *)

let pp_pair (r, c) = Printf.sprintf "(%d,%d)" r c

let pp_list lst =
  "[" ^ String.concat "; " (List.map pp_pair lst) ^ "]"

let pp_opt = function
  | None -> "None"
  | Some lst -> "Some " ^ pp_list lst

let cmp_set lst1 lst2 =
  List.sort compare lst1 = List.sort compare lst2

(* --- Test helpers --- *)

let empty_board () = Array.make_matrix 20 20 '_'

let set_cells board color cells =
  List.iter (fun (r, c) -> board.(r).(c) <- color) cells;
  board

(* ================================================================
   compute_corners: given piece cells, returns diagonal positions
   that aren't the cells themselves and aren't face-adjacent to any
   cell. These are the valid "corner touch" points for Blokus.
   ================================================================ *)

let compute_corners_tests = "compute_corners" >::: [
    (* Single cell: all 4 diagonals are corners *)
    "monomino (0,0)" >:: (fun _ ->
        assert_equal ~cmp:cmp_set ~printer:pp_list
          [(-1,-1); (-1,1); (1,-1); (1,1)]
          (compute_corners [(0,0)]));

    (* Horizontal domino: middle diags are face-adjacent, only ends remain *)
    "domino horizontal" >:: (fun _ ->
        assert_equal ~cmp:cmp_set ~printer:pp_list
          [(-1,-1); (-1,2); (1,-1); (1,2)]
          (compute_corners [(0,0); (0,1)]));

    "domino vertical" >:: (fun _ ->
        assert_equal ~cmp:cmp_set ~printer:pp_list
          [(-1,-1); (-1,1); (2,-1); (2,1)]
          (compute_corners [(0,0); (1,0)]));

    (* L-shape: 5 corners (the inner bend has none) *)
    "L-tromino" >:: (fun _ ->
        let corners = compute_corners [(0,0); (0,1); (1,1)] in
        assert_equal ~cmp:cmp_set ~printer:pp_list
          [(-1,-1); (-1,2); (1,-1); (2,0); (2,2)]
          corners);

    "straight tromino" >:: (fun _ ->
        assert_equal ~cmp:cmp_set ~printer:pp_list
          [(-1,-1); (-1,3); (1,-1); (1,3)]
          (compute_corners [(0,0); (0,1); (0,2)]));

    (* 2x2 square: only the 4 outer diagonals *)
    "2x2 square" >:: (fun _ ->
        assert_equal ~cmp:cmp_set ~printer:pp_list
          [(-1,-1); (-1,2); (2,-1); (2,2)]
          (compute_corners [(0,0); (0,1); (1,0); (1,1)]));

    (* T-shape: 6 corners — inner diags are face-adjacent *)
    "T-tetromino" >:: (fun _ ->
        assert_equal ~cmp:cmp_set ~printer:pp_list
          [(-1,0); (-1,2); (0,-1); (0,3); (2,-1); (2,3)]
          (compute_corners [(0,1); (1,0); (1,1); (1,2)]));
  ]

(* ================================================================
   translate: offset piece coords to board position.
   Replaces the old place_piece/subtract_from_init/place_algo chain.
   ================================================================ *)

let translate_tests = "translate" >::: [
    "zero offset" >:: (fun _ ->
        assert_equal [(0,0); (0,1)]
          (translate [(0,0); (0,1)] (0,0)));

    "positive offset" >:: (fun _ ->
        assert_equal [(5,5); (5,6); (6,5)]
          (translate [(0,0); (0,1); (1,0)] (5,5)));

    "negative offset" >:: (fun _ ->
        assert_equal [(-1,-1); (-1,0)]
          (translate [(0,0); (0,1)] (-1,-1)));
  ]

(* ================================================================
   check_corners: Blokus rule — placed piece must diagonally touch
   at least one same-color cell already on the board.
   ================================================================ *)

let check_corners_tests = "check_corners" >::: [
    "empty board — nothing to touch" >:: (fun _ ->
        let board = empty_board () in
        assert_equal false
          (check_corners 'R' [(2,2); (3,2)] board));

    "diagonal touch same color — valid" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R'
            [(0,0); (0,1); (1,0); (1,1)] in
        assert_equal true
          (check_corners 'R' [(2,2)] board));

    "face touch only — doesn't count as corner" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(0,0)] in
        assert_equal false
          (check_corners 'R' [(1,0)] board));

    "diagonal touch different color — doesn't count" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'B' [(0,0)] in
        assert_equal false
          (check_corners 'R' [(1,1)] board));

    "diagonal at board edge" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(0,0)] in
        assert_equal true
          (check_corners 'R' [(1,1)] board));

    "multi-cell piece, one cell touches diag" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R'
            [(0,0); (0,1); (1,0); (1,1)] in
        assert_equal true
          (check_corners 'R' [(2,2); (2,3); (3,2)] board));

    "cell on top of existing — excluded from diag check" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(5,5)] in
        (* placing on (5,5) itself: diag neighbor is itself, shouldn't count *)
        assert_equal false
          (check_corners 'R' [(5,5)] board));
  ]

(* ================================================================
   check_faces: Blokus rule — placed piece must NOT share an edge
   with any same-color cell on the board.
   ================================================================ *)

let check_faces_tests = "check_faces" >::: [
    "empty board — no contact" >:: (fun _ ->
        assert_equal true
          (check_faces 'R' [(5,5)] (empty_board ())));

    "face-adjacent same color — invalid" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(4,5)] in
        assert_equal false
          (check_faces 'R' [(5,5)] board));

    "face-adjacent different color — ok" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'B' [(4,5)] in
        assert_equal true
          (check_faces 'R' [(5,5)] board));

    "diagonal same color — ok (not a face)" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(4,4)] in
        assert_equal true
          (check_faces 'R' [(5,5)] board));

    "multi-cell, one face touches" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(3,0)] in
        assert_equal false
          (check_faces 'R' [(4,0); (5,0); (5,1)] board));

    "at board edge — doesn't wrap" >:: (fun _ ->
        let board = empty_board () in
        assert_equal true
          (check_faces 'R' [(0,0)] board));
  ]

(* ================================================================
   starting_pos: first move must cover one of the 4 board corners.
   ================================================================ *)

let starting_pos_tests = "starting_pos" >::: [
    "covers (0,0)" >:: (fun _ ->
        assert_equal true (starting_pos [(0,0); (0,1)]));

    "covers (0,19)" >:: (fun _ ->
        assert_equal true (starting_pos [(0,18); (0,19)]));

    "covers (19,0)" >:: (fun _ ->
        assert_equal true (starting_pos [(19,0)]));

    "covers (19,19)" >:: (fun _ ->
        assert_equal true (starting_pos [(18,19); (19,19)]));

    "middle of board — invalid" >:: (fun _ ->
        assert_equal false (starting_pos [(5,5); (5,6)]));
  ]

(* ================================================================
   validate_placement: full integration — translates coords, checks
   bounds, emptiness, faces, corners/starting_pos. Returns Some cells
   if valid, None if not. No mutation.
   ================================================================ *)

let validate_placement_tests = "validate_placement" >::: [
    "first move on corner — valid" >:: (fun _ ->
        let board = empty_board () in
        let result = validate_placement 'B' [(0,0); (0,1)] board (0,0) true in
        assert_equal ~printer:pp_opt
          (Some [(0,0); (0,1)]) result);

    "first move not on corner — invalid" >:: (fun _ ->
        let board = empty_board () in
        let result = validate_placement 'B' [(0,0)] board (5,5) true in
        assert_equal ~printer:pp_opt None result);

    "first move bottom-right corner" >:: (fun _ ->
        let board = empty_board () in
        let result = validate_placement 'B' [(0,0)] board (19,19) true in
        assert_equal ~printer:pp_opt (Some [(19,19)]) result);

    "out of bounds — invalid" >:: (fun _ ->
        let board = empty_board () in
        let result = validate_placement 'B' [(0,0); (0,1)] board (19,19) true in
        assert_equal ~printer:pp_opt None result);

    "overlap with existing piece — invalid" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(0,0)] in
        let result = validate_placement 'B' [(0,0)] board (0,0) true in
        assert_equal ~printer:pp_opt None result);

    "second move with corner touch — valid" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R'
            [(0,0); (0,1); (1,0); (1,1)] in
        let result = validate_placement 'R' [(0,0)] board (2,2) false in
        assert_equal ~printer:pp_opt (Some [(2,2)]) result);

    "second move no corner touch — invalid" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(0,0)] in
        let result = validate_placement 'R' [(0,0)] board (5,5) false in
        assert_equal ~printer:pp_opt None result);

    "second move face touch — invalid" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'R' [(0,0)] in
        let result = validate_placement 'R' [(0,0)] board (1,0) false in
        assert_equal ~printer:pp_opt None result);

    "L-piece valid placement" >:: (fun _ ->
        let board = set_cells (empty_board ()) 'G'
            [(0,0); (0,1); (1,1)] in
        let coords = [(0,0); (0,1); (1,0)] in
        let result = validate_placement 'G' coords board (2,2) false in
        assert_equal ~printer:pp_opt
          (Some [(2,2); (2,3); (3,2)]) result);
  ]

(* ================================================================
   score: derived from inventory. Each remaining cell = -1 point.
   ================================================================ *)

let score_tests = "score" >::: [
    "full inventory is -89" >:: (fun _ ->
        assert_equal ~printer:string_of_int (-89) (score player_blue));

    "empty inventory is 0" >:: (fun _ ->
        assert_equal ~printer:string_of_int
          0 (score { inventory = []; color = 'R' }));

    "removing monomino gains 1 point" >:: (fun _ ->
        let monomino_b = List.hd player_blue.inventory in
        let p = placed_piece monomino_b player_blue in
        assert_equal ~printer:string_of_int (-88) (score p));
  ]

(* ================================================================
   piece definitions: spot-check correctness of the 21 pieces.
   ================================================================ *)

let piece_count_tests = "piece definitions" >::: [
    "21 pieces total" >:: (fun _ ->
        assert_equal ~printer:string_of_int 21 (List.length pieces));

    "monomino has 1 cell" >:: (fun _ ->
        let p = List.nth pieces 0 in
        List.iter (fun o ->
          assert_equal ~printer:string_of_int 1 (List.length o.coordinates)
        ) p.shape);

    "domino has 2 cells" >:: (fun _ ->
        let p = List.nth pieces 1 in
        List.iter (fun o ->
          assert_equal ~printer:string_of_int 2 (List.length o.coordinates)
        ) p.shape);

    "pentominoes have 5 cells" >:: (fun _ ->
        for i = 9 to List.length pieces - 1 do
          let p = List.nth pieces i in
          List.iter (fun o ->
            assert_equal ~printer:string_of_int
              ~msg:(Printf.sprintf "piece %d" i)
              5 (List.length o.coordinates)
          ) p.shape
        done);

    "all orientations same cell count per piece" >:: (fun _ ->
        List.iteri (fun i p ->
          match p.shape with
          | [] -> ()
          | first :: rest ->
            let n = List.length first.coordinates in
            List.iter (fun o ->
              assert_equal ~printer:string_of_int
                ~msg:(Printf.sprintf "piece %d orientation mismatch" i)
                n (List.length o.coordinates)
            ) rest
        ) pieces);
  ]

(* ================================================================
   player management: inventory, turn order, removal.
   ================================================================ *)

let player_tests = "player management" >::: [
    "placed_piece removes from inventory" >:: (fun _ ->
        let monomino_b = List.hd player_blue.inventory in
        let p = placed_piece monomino_b player_blue in
        assert_equal ~printer:string_of_int
          (List.length player_blue.inventory - 1)
          (List.length p.inventory));

    "get_next_player wraps around" >:: (fun _ ->
        let players =
          [player_blue; player_green; player_red; player_yellow] in
        let next = get_next_player players player_yellow in
        assert_equal 'B' next.color);

    "get_next_player advances" >:: (fun _ ->
        let players =
          [player_blue; player_green; player_red; player_yellow] in
        let next = get_next_player players player_blue in
        assert_equal 'G' next.color);

    "remove_player reduces list" >:: (fun _ ->
        let players = [player_blue; player_green; player_red] in
        let result = remove_player players player_green in
        assert_equal ~printer:string_of_int 2 (List.length result));
  ]

(* ================================================================
   Run all tests
   ================================================================ *)

let suite =
  "blokus tests" >::: [
    compute_corners_tests;
    translate_tests;
    check_corners_tests;
    check_faces_tests;
    starting_pos_tests;
    validate_placement_tests;
    score_tests;
    piece_count_tests;
    player_tests;
  ]

let () = run_test_tt_main suite
