open Bogue
module W = Widget
module L = Layout

let grid_size = 20
let cell_logical = 30
let board_logical = grid_size * cell_logical

let empty_color = (220, 220, 220, 255)
let grid_color = (180, 180, 180, 255)
let highlight_color = (70, 130, 230, 255)

let board = Array.make_matrix grid_size grid_size false

let draw_grid area =
  let pw, _ph = Sdl_area.drawing_size area in
  let cell_px = pw / grid_size in
  Sdl_area.clear area;
  for row = 0 to grid_size - 1 do
    for col = 0 to grid_size - 1 do
      let x = col * cell_px in
      let y = row * cell_px in
      let color = if board.(row).(col) then highlight_color else empty_color in
      Sdl_area.fill_rectangle area ~color ~w:(cell_px - 1) ~h:(cell_px - 1) (x, y);
      Sdl_area.draw_rectangle area ~color:grid_color ~thick:1 ~w:cell_px ~h:cell_px (x, y)
    done
  done;
  Sdl_area.update area

let () =
  let w = W.sdl_area ~w:board_logical ~h:board_logical () in
  let area = W.get_sdl_area w in
  let startup_action _src _dst _ev = draw_grid area in
  let click_action _src _dst ev =
    let px, py = Sdl_area.pointer_pos area ev in
    let pw, _ph = Sdl_area.drawing_size area in
    let cell_px = pw / grid_size in
    let col = px / cell_px in
    let row = py / cell_px in
    if row >= 0 && row < grid_size && col >= 0 && col < grid_size then begin
      board.(row).(col) <- not board.(row).(col);
      draw_grid area
    end
  in
  let c1 = W.connect_main w w startup_action [Trigger.startup] in
  let c2 = W.connect_main w w click_action Trigger.buttons_down in
  let layout = L.resident ~background:(L.color_bg (40, 40, 40, 255)) w in
  let shortcuts = Main.shortcuts_of_list [Main.exit_on_escape] in
  let board_gui = Main.of_layout ~shortcuts ~connections:[c1; c2] layout in
  Main.run board_gui
