/// @description UI
draw_set_font(fnt_main)
draw_set_color(c_black)
draw_text(10, 10, $"fps - {fps_real}")
draw_text(10, 25, $"tool - {global.selected_tool}")
draw_set_color(c_white)