/// scr_collision_core
/// Core functions to check if positions or rectangles hit solid tiles.

/**
 * @function solid_at(_x, _y)
 * @desc Returns true if the given pixel position collides with a solid tile.
 */
function solid_at(_x, _y) {
    var tmap = global.TILEMAP_COLLISION;
    if (tmap == noone) return false;
    return tilemap_get_at_pixel(tmap, _x, _y) != 0;
}

/**
 * @function rect_hits_solid(_l, _t, _r, _b)
 * @desc Checks if the rectangle (left, top, right, bottom) touches a solid tile.
 */
function rect_hits_solid(_l, _t, _r, _b) {
    var li = _l + mask_inset;
    var ri = _r - mask_inset;
    var ti = _t + mask_inset;
    var bi = _b;

    return (
        solid_at(li, ti) || solid_at(ri, ti) ||
        solid_at(li, bi) || solid_at(ri, bi)
    );
}