if (__return) {
	instance_destroy()
	exit
}
var _getcolor = draw_get_color()
draw_set_color(global.cv_color)
surface_set_target(global.surf_canvas)

repeat (100) {
	if (ds_queue_size(s) > 0) {
		
		var __temp = ds_queue_dequeue(s)
		var _curx = __temp[0]
		var _cury = __temp[1]
		
		var _old_color = surface_getpixel(global.surf_canvas, _curx, _cury)
		if (__inside(_curx,_cury) && _old_color == prev_color) {
			
			draw_point(_curx, _cury)
			
			ds_queue_enqueue(s, [_curx + 1, _cury])
			ds_queue_enqueue(s, [_curx - 1, _cury])
			ds_queue_enqueue(s, [_curx, _cury + 1])
			ds_queue_enqueue(s, [_curx, _cury - 1])
		}
		
	} else {
		draw_set_color(_getcolor)
		//surface_reset_target()
		instance_destroy()
		break
	}
}

draw_set_color(_getcolor)
surface_reset_target()