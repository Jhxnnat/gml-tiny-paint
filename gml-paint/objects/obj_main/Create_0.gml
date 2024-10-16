/// @description initial values
//show_debug_overlay(true)
game_set_speed(60, gamespeed_fps)

x1 = 0
y1 = 0

x2 = 0
y2 = 0

line_start_x = 0
line_start_y = 0
is_drawing_line = false

drag_prev_x = -1;
drag_prev_y = -1;

is_drawing = false

draw_arr = [ surface_create(CW,CH) ];
redo = [];

canvas_init();

//cam setup
global.cam = view_camera[0]
camera_set_view_size(global.cam,WINDOW_W*global.cv_zoom,WINDOW_H*global.cv_zoom)
cx = 0
cy = 0

//ui
window_set_cursor(cr_none)
display_set_gui_size(floor(WINDOW_W/2), floor(WINDOW_H/2))
guiw = display_get_gui_width()
guih = display_get_gui_height()
ui_w = 16*4
ui_h = guih
ui_coord = [guiw-ui_w, 0, guiw, ui_h]
clicked_ui = false
//cursor = spr_arrow_cur
status_w = guiw-ui_w
status_h = 21