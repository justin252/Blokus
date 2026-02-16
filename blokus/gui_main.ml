open Bogue
module W = Widget
module L = Layout

let grid_size = Player.board_size
let cell_logical = 30
let board_logical = grid_size * cell_logical

let empty_color = (220, 220, 220, 255)
let grid_color = (180, 180, 180, 255)

let color_of_char = function
  | 'B' -> (50, 100, 220, 255)
  | 'G' -> (50, 180, 80, 255)
  | 'R' -> (220, 60, 60, 255)
  | 'Y' -> (230, 200, 50, 255)
  | _ -> empty_color

let state = ref (Gui_state.init ())

let draw_grid area =
  let pw, _ph = Sdl_area.drawing_size area in
  let cell_px = pw / grid_size in
  Sdl_area.clear area;
  for row = 0 to grid_size - 1 do
    for col = 0 to grid_size - 1 do
      let x = col * cell_px in
      let y = row * cell_px in
      let color = color_of_char (!state).board.(row).(col) in
      Sdl_area.fill_rectangle area ~color ~w:(cell_px - 1) ~h:(cell_px - 1) (x, y);
      Sdl_area.draw_rectangle area ~color:grid_color ~thick:1 ~w:cell_px ~h:cell_px (x, y)
    done
  done;
  Sdl_area.update area

let status_text () =
  let st = !state in
  let color_name = function
    | 'B' -> "Blue" | 'G' -> "Green" | 'R' -> "Red" | 'Y' -> "Yellow" | _ -> "?"
  in
  let name = color_name st.current.color in
  let n = List.length st.current.inventory in
  Printf.sprintf "%s's turn | Piece %d/%d | Orient %d"
    name st.selected_piece n st.selected_orient

let () =
  let w = W.sdl_area ~w:board_logical ~h:board_logical () in
  let area = W.get_sdl_area w in
  let label = W.label ~size:16 (status_text ()) in

  let update_label () =
    Label.set (W.get_label label) (status_text ())
  in

  let startup_action _src _dst _ev = draw_grid area in

  let click_action _src _dst ev =
    let px, py = Sdl_area.pointer_pos area ev in
    let pw, _ph = Sdl_area.drawing_size area in
    let cell_px = pw / grid_size in
    let col = px / cell_px in
    let row = py / cell_px in
    if row >= 0 && row < grid_size && col >= 0 && col < grid_size then begin
      state := Gui_state.place !state (row, col);
      draw_grid area;
      update_label ()
    end
  in

  let c1 = W.connect_main w w startup_action [Trigger.startup] in
  let c2 = W.connect_main w w click_action Trigger.buttons_down in
  let board_layout = L.resident w in
  let label_layout = L.resident label in
  let layout = L.tower [label_layout; board_layout] in
  let shortcuts = Main.shortcuts_of_list [Main.exit_on_escape] in
  let board_gui = Main.of_layout ~shortcuts ~connections:[c1; c2] layout in
  Main.run board_gui
