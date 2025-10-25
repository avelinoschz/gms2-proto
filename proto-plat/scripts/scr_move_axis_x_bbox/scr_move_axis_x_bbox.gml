/// scr_move_axis_x

/**
 * @function move_axis_x(_amount)
 * @desc Moves the instance in X, pixel-by-pixel, until a solid is hit.
 */
function move_axis_x(_amount) {
    var dir       = sign(_amount);
    var steps     = abs(floor(_amount));
    var frac_part = _amount - dir * steps;

    repeat (steps) {
        if (!rect_hits_solid(bbox_left + dir, bbox_top, bbox_right + dir, bbox_bottom)) {
            x += dir;
        } else {
            hsp = 0;
            return;
        }
    }

    if (frac_part != 0) {
        if (!rect_hits_solid(bbox_left + frac_part, bbox_top, bbox_right + frac_part, bbox_bottom)) {
            x += frac_part;
        } else {
            hsp = 0;
        }
    }
}

