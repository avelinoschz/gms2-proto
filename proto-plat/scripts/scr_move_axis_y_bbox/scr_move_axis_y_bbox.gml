/// scr_move_axis_y
/// Handles vertical movement with solid collision detection.

/**
 * @function move_axis_y(_amount)
 * @desc Moves the instance in Y until a solid is hit. Returns true if landed on ground.
 */
function move_axis_y(_amount) {
    var dir       = sign(_amount);
    var steps     = abs(floor(_amount));
    var frac_part = _amount - dir * steps;
    var landed    = false;

    repeat (steps) {
        if (!rect_hits_solid(bbox_left, bbox_top + dir, bbox_right, bbox_bottom + dir)) {
            y += dir;
        } else {
            if (dir > 0) landed = true;
            vsp = 0;
            break;
        }
    }

    if (vsp != 0 && frac_part != 0) {
        if (!rect_hits_solid(bbox_left, bbox_top + frac_part, bbox_right, bbox_bottom + frac_part)) {
            y += frac_part;
        } else {
            if (frac_part > 0) landed = true;
            vsp = 0;
        }
    }

    return landed;
}

/**
 * @function other()
 * @desc Simply other.
 */
function otherf(){
	return true;
}