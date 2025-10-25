/// obj_player - Step

// Horizontal movement direction and accel
var move  = keyboard_check(vk_right) - keyboard_check(vk_left);
var accel = on_ground ? accel_ground : accel_air;

// Acceleration
if (move != 0) {
    hsp = lerp(hsp, move * walk_speed, accel);
	
} else if (on_ground) 
{
    // Deceleration by applying friction when no input
    hsp *= friction_ground;
    if (abs(hsp) < 0.05)
	{
		hsp = 0;
	}
}

// Gravity
vsp += grav;
if (vsp > max_fall)
{
	vsp = max_fall;
}

// Coyote time & Jump buffer
if (keyboard_check_pressed(vk_space))
{
	jumpbuf = jumpbuf_max;
}

if (on_ground){
	coyote = coyote_max;
}

// Jump
if (jumpbuf > 0 && coyote > 0) {
    vsp = jump_speed;
    jumpbuf = -1;
    coyote = 0;
}

// Jump cut
if (vsp < 0 && keyboard_check_released(vk_space)) {
    vsp *= jump_cut_mult;
}

// Actual move
// This functions use bbox to handle collisions and movement
// Look at scr_move_axis_x_bbox and scr_move_axis_y_bbox scripts
move_axis_x(hsp);
var landed = move_axis_y(vsp);

//Update on_ground state
// This function uses bbox to handle collisions and movement
// Look at scr_collision_core_bbox script
on_ground = landed || rect_hits_solid(bbox_left, bbox_top + 1, bbox_right, bbox_bottom + 1);

// Countdown timers for forgiveness windwos
if (jumpbuf >= 0)
{
	jumpbuf--;
}

if (coyote > 0) 
{
	coyote--;
}

otherf();