// ==========================================================
// === INPUT ===
// ==========================================================
//
// Reads player input and converts it into a movement direction.
// Supports both arrow keys and WASD.
//

var right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
var left_key  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var move = (right_key ? 1 : 0) - (left_key ? 1 : 0);


// ==========================================================
// === WALL DETECTION ===
// ==========================================================
//
// Checks for tile collisions on both sides to detect wall contact.
// Used for wall slides and wall jumps.
//

touching_left  = place_meeting(x - 1, y, global.TILEMAP_COLLISION);
touching_right = place_meeting(x + 1, y, global.TILEMAP_COLLISION);
on_wall = (touching_left && move < 0) || (touching_right && move > 0);


// ==========================================================
// === HORIZONTAL MOVEMENT ===
// ==========================================================
//
// Applies horizontal acceleration and clamps speed.
// If wall jump lock is active, ignores player input.
//

if (wall_jump_timer > 0) {
    wall_jump_timer--;
}
else {
    if (move != 0) {
        hsp += move * accel;
        hsp = clamp(hsp, -walk_speed, walk_speed);
    } else {
        hsp = 0;
    }
}

// Update facing direction for visuals
if (move != 0) facing = sign(move);
image_xscale = facing;


// ==========================================================
// === GRAVITY & WALL SLIDE ===
// ==========================================================
//
// Applies variable gravity depending on vertical direction.
// When sliding on a wall, applies a smoothed friction effect
// to prevent inconsistent “sticky” movement.
//

if (on_wall && !on_ground && vsp > 0) {
    // Smoothly approach target slide speed for consistency
    var target_slide = slide_speed;
    vsp = lerp(vsp, target_slide, 0.25);

} else {
    // Normal gravity (different values for upward / downward movement)
    if (vsp < 0) vsp += grav_up;
    else         vsp += grav_down;

    if (vsp > max_fall) vsp = max_fall;
}


// ==========================================================
// === COYOTE & JUMP BUFFER ===
// ==========================================================
//
// Stores input leniency: allows jumps for a few frames
// after leaving a ledge (coyote) or before landing (jump buffer).
//

if (keyboard_check_pressed(vk_space)) jumpbuf = jumpbuf_max;
if (on_ground) coyote = coyote_max;


// ==========================================================
// === JUMP LOGIC ===
// ==========================================================
//
// Evaluates if a jump can be performed based on coyote time,
// wall contact, and remaining extra jumps (double jump).
//

if (jumpbuf > 0) {
    var can_jump = false;

    // Normal / Coyote jump
    if (coyote > 0) {
        can_jump = true;
    }
    // Wall jump
    else if (on_wall) {
        can_jump = true;

        // --- WALL JUMP IMPULSE ---
        if (touching_left)  hsp =  wall_jump_hsp;   // push right
        if (touching_right) hsp = -wall_jump_hsp;   // push left

        vsp = jump_speed;
        wall_jump_timer = wall_jump_lock; // apply horizontal lock
    }
    // Double jump
    else if (extra_jumps > 0) {
        can_jump = true;
        extra_jumps--;
    }

    // --- Apply jump ---
    if (can_jump) {
        vsp = jump_speed;
        jumpbuf = -1;
        coyote = 0;
    }
}


// ==========================================================
// === JUMP CUT ===
// ==========================================================
//
// Reduces jump height when the player releases the jump key early,
// creating a responsive “short hop” mechanic.
//

if (vsp < 0 && keyboard_check_released(vk_space)) {
    vsp *= jump_cut_mult;
}


// ==========================================================
// === MOVE AND COLLIDE ===
// ==========================================================
//
// Moves the player using built-in collision checks
// against the tilemap defined in global.TILEMAP_COLLISION.
//

move_and_collide(hsp, 0, global.TILEMAP_COLLISION);
move_and_collide(0, vsp, global.TILEMAP_COLLISION);


// ==========================================================
// === COLLISION STATES ===
// ==========================================================
//
// Updates grounded / ceiling states and resolves vertical velocity
// if a ceiling collision occurs.
//

on_ground = place_meeting(x, y + 1, global.TILEMAP_COLLISION);
hit_head  = place_meeting(x, y - 1, global.TILEMAP_COLLISION);

if (hit_head && vsp < 0) vsp = 0;

// Reset double jump only when touching ground, not walls
if (on_ground && !on_wall) {
    extra_jumps = max_extra_jumps;
}


// ==========================================================
// === TIMERS DECAY ===
// ==========================================================
//
// Decreases active timers for jump buffer and coyote time.
//

if (jumpbuf >= 0) jumpbuf--;
if (coyote > 0)  coyote--;

    
// ==========================================================
// === SPRITE HANDLING ===
// ==========================================================
//
// Rules:
// - Grounded: idle or run
// - Air (not on wall): jump if still has double jump, double_jump if out
// - On wall: wall_slide if can still jump, otherwise double_jump
//
// extra_jumps == max_extra_jumps → hasn’t spent midair jump yet
// extra_jumps  > 0               → still has a midair jump left
// extra_jumps <= 0               → no air jumps available
//

if (on_wall && !on_ground) {

    // On a wall in the air
    if (extra_jumps > 0) {
        sprite_index = spr_player_wall_slide;
    } else {
        sprite_index = spr_player_wall_slide_no_jump;
    }

}
else if (!on_ground) {

    // In the air but not on a wall
    if (extra_jumps == max_extra_jumps) {
        sprite_index = spr_player_jump;
    }
    else if (extra_jumps > 0) {
        sprite_index = spr_player_jump;
    }
    else {
        sprite_index = spr_player_double_jump;
    }

}
else {
    // On the ground
    if (abs(hsp) > 0.1) {
        sprite_index = spr_player_run;
    } else {
        sprite_index = spr_player_idle;
    }
}