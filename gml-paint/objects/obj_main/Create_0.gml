/// @description initial values

//window_set_cursor(cr_none);

x1 = 0
y1 = 0

x2 = 0
y2 = 0

drag_prev_x = -1;
drag_prev_y = -1;

is_drawing = false


draw_arr = [ surface_create(CW,CH) ];
redo = [];

canvas_init();

//cam setup
global.cam = view_camera[0]
cx = 0
cy = 0