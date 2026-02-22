open Bogue
module W = Widget
module L = Layout

let grid_size = Player.board_size
let cell_logical = 30
let board_logical = grid_size * cell_logical

let thumb_cell = 7
let thumb_pad = 6
let panel_cols = 3
let panel_rows = 7
let panel_margin = 8
let panel_w = panel_cols * (5 * thumb_cell + thumb_pad) + 2 * panel_margin

let empty_color = (220, 220, 220, 255)
let grid_color = (180, 180, 180, 255)
let panel_bg = (50, 50, 55, 255)
let select_color = (255, 255, 255, 180)
let invalid_overlay = (0, 0, 0, 160)

(** Map color variant to RGBA — takes Player.color directly *)
let color_of_player = function
  | Player.Blue -> (50, 100, 220, 255)
  | Player.Green -> (50, 180, 80, 255)
  | Player.Red -> (220, 60, 60, 255)
  | Player.Yellow -> (230, 200, 50, 255)

let ghost_color_of_player = function
  | Player.Blue -> (50, 100, 220, 120)
  | Player.Green -> (50, 180, 80, 120)
  | Player.Red -> (220, 60, 60, 120)
  | Player.Yellow -> (230, 200, 50, 120)

(** Map board cell (color option) to RGBA *)
let color_of_cell = function
  | Some c -> color_of_player c
  | None -> empty_color

let color_name = function
  | Player.Blue -> "Blue" | Player.Green -> "Green"
  | Player.Red -> "Red" | Player.Yellow -> "Yellow"

(* Global refs — Bogue's callback model requires mutable state *)
let state = ref (Gui_state.init ())
let hover_cell = ref (-1, -1)

let draw_board area =
  let pw, _ph = Sdl_area.drawing_size area in
  let cell_px = pw / grid_size in
  Sdl_area.clear area;
  Array.iteri (fun row row_arr ->
    Array.iteri (fun col cell ->
      let x = col * cell_px in
      let y = row * cell_px in
      let color = color_of_cell cell in
      Sdl_area.fill_rectangle area ~color ~w:(cell_px - 1) ~h:(cell_px - 1) (x, y);
      Sdl_area.draw_rectangle area ~color:grid_color ~thick:1 ~w:cell_px ~h:cell_px (x, y)
    ) row_arr
  ) (!state).board;
  if not (!state).game_over then begin
    let hr, hc = !hover_cell in
    if hr >= 0 then begin
      match Gui_state.preview_cells !state (hr, hc) with
      | None -> ()
      | Some (cells, is_valid) ->
        let ghost = ghost_color_of_player (!state).current.Player.color in
        List.iter (fun (r, c) ->
          if r >= 0 && r < grid_size && c >= 0 && c < grid_size then begin
            let x = c * cell_px and y = r * cell_px in
            Sdl_area.fill_rectangle area ~color:ghost
              ~w:(cell_px - 1) ~h:(cell_px - 1) (x, y);
            if not is_valid then
              Sdl_area.fill_rectangle area ~color:invalid_overlay
                ~w:(cell_px - 1) ~h:(cell_px - 1) (x, y)
          end
        ) cells
    end
  end;
  Sdl_area.update area

let draw_panel panel_area =
  let st = !state in
  let sx, sy = Sdl_area.to_pixels (1, 1) in
  let tc = thumb_cell * sx in
  let pad = thumb_pad * sy in
  let slot = 5 * tc + pad in
  let mx = panel_margin * sx in
  Sdl_area.clear panel_area;
  let pw, ph = Sdl_area.drawing_size panel_area in
  Sdl_area.fill_rectangle panel_area ~color:panel_bg ~w:pw ~h:ph (0, 0);
  if st.game_over then begin
    Sdl_area.update panel_area
  end else begin
    let player_color = color_of_player st.current.color in
    List.iteri (fun i piece ->
      let col = i / panel_rows in
      let row = i mod panel_rows in
      let x_off = mx + col * slot in
      let y_off = mx + row * slot in
      let coords = if i = st.selected_piece then
        (List.nth piece.Player.shape st.selected_orient).Player.coordinates
      else
        (List.hd piece.Player.shape).Player.coordinates
      in
      List.iter (fun (r, c) ->
        Sdl_area.fill_rectangle panel_area ~color:player_color
          ~w:(tc - 1) ~h:(tc - 1) (x_off + c * tc, y_off + r * tc)
      ) coords;
      if i = st.selected_piece then
        Sdl_area.draw_rectangle panel_area ~color:select_color ~thick:2
          ~w:(5 * tc + 2) ~h:(5 * tc + 2) (x_off - 2, y_off - 2)
    ) st.current.inventory;
    Sdl_area.update panel_area
  end

let score_text () =
  let scores = Gui_state.scores !state in
  String.concat "  " (List.map (fun (c, s) ->
    Printf.sprintf "%s: %d" (color_name c) s
  ) scores)

let status_text () =
  let st = !state in
  if st.game_over then
    "Game Over! " ^ score_text ()
  else
    let orient_count = match Gui_state.current_piece st with
      | None -> 0
      | Some p -> List.length p.Player.shape
    in
    Printf.sprintf "%s | Piece %d/%d | Orient %d/%d"
      (color_name st.current.color)
      st.selected_piece
      (List.length st.current.inventory)
      st.selected_orient
      orient_count

let () =
  let board_w = W.sdl_area ~w:board_logical ~h:board_logical () in
  let board_area = W.get_sdl_area board_w in
  let panel_w_widget = W.sdl_area ~w:panel_w ~h:board_logical () in
  let panel_area = W.get_sdl_area panel_w_widget in
  let label = W.label ~size:14 (status_text ()) in
  let score_label = W.label ~size:14 (score_text ()) in

  let refresh () =
    draw_board board_area;
    draw_panel panel_area;
    Label.set (W.get_label label) (status_text ());
    Label.set (W.get_label score_label) (score_text ())
  in

  let startup _src _dst _ev = refresh () in

  let board_click _src _dst ev =
    if not (!state).game_over then begin
      let px, py = Sdl_area.pointer_pos board_area ev in
      let pw, _ph = Sdl_area.drawing_size board_area in
      let cell_px = pw / grid_size in
      let col = px / cell_px in
      let row = py / cell_px in
      if row >= 0 && row < grid_size && col >= 0 && col < grid_size then begin
        state := Gui_state.place !state (row, col);
        hover_cell := (-1, -1);
        refresh ()
      end
    end
  in

  let board_hover _src _dst ev =
    if not (!state).game_over then begin
      let px, py = Sdl_area.pointer_pos board_area ev in
      let pw, _ph = Sdl_area.drawing_size board_area in
      let cell_px = pw / grid_size in
      let col = px / cell_px in
      let row = py / cell_px in
      let prev = !hover_cell in
      if (row, col) <> prev then begin
        hover_cell := (row, col);
        draw_board board_area
      end
    end
  in

  let board_leave _src _dst _ev =
    hover_cell := (-1, -1);
    draw_board board_area
  in

  let panel_click _src _dst ev =
    if not (!state).game_over then begin
      let px, py = Sdl_area.pointer_pos panel_area ev in
      let sx, sy = Sdl_area.to_pixels (1, 1) in
      let tc = thumb_cell * sx in
      let pad = thumb_pad * sy in
      let slot = 5 * tc + pad in
      let mx = panel_margin * sx in
      let col = (px - mx) / slot in
      let row = (py - mx) / slot in
      if col >= 0 && col < panel_cols && row >= 0 && row < panel_rows then begin
        let idx = col * panel_rows + row in
        let n = List.length (!state).current.Player.inventory in
        if idx >= 0 && idx < n then begin
          state := Gui_state.select_piece !state idx;
          refresh ()
        end
      end
    end
  in

  let c1 = W.connect_main board_w board_w startup [Trigger.startup] in
  let c2 = W.connect_main board_w board_w board_click Trigger.buttons_down in
  let c3 = W.connect_main board_w board_w board_hover Trigger.pointer_motion in
  let c4 = W.connect_main board_w board_w board_leave [Trigger.mouse_leave] in
  let c5 = W.connect_main panel_w_widget panel_w_widget panel_click Trigger.buttons_down in
  let board_layout = L.resident board_w in
  let panel_layout = L.resident panel_w_widget in
  let label_layout = L.resident label in
  let score_layout = L.resident score_label in
  let game_row = L.flat [board_layout; panel_layout] in
  let layout = L.tower [label_layout; game_row; score_layout] in
  let shortcuts = Main.shortcuts_of_list [ Main.exit_on_escape ] in
  let connections = [c1; c2; c3; c4; c5] in
  let board_gui = Main.of_layout ~shortcuts ~connections layout in
  Main.run board_gui
