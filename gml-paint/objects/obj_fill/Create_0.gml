s = ds_queue_create()

__return = false

if !__inside(x,y) { __return = true }

prev_color = surface_getpixel(global.surf_canvas,x,y)
if (prev_color = global.cv_color) __return = true

if __return { exit }

ds_queue_enqueue(s, [x,y])