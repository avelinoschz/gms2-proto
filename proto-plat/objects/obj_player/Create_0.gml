// ==========================================================
// === PLAYER MOVEMENT CONFIGURATION ===
// ==========================================================
//
// Defines all movement, gravity, jump, and wall behavior settings.
// Each section below is grouped by system: horizontal, vertical,
// wall, jump, and input forgiveness.
//

// ==========================================================
// === HORIZONTAL MOVEMENT ===
// ==========================================================
//
// Controls ground responsiveness and movement feel.
//

walk_speed    = 1.2;   // Maximum horizontal speed (lower = heavier feel)
accel         = 0.35;  // Acceleration (responsiveness control)
// No friction: horizontal speed stops instantly when no input is held.


// ==========================================================
// === VERTICAL MOVEMENT ===
// ==========================================================
//
// Configures gravity and jump parameters. These values define how
// floaty or heavy the character feels in mid-air.
//

grav_up       = 0.20;  // Gravity while moving upward (weaker = floatier jumps)
grav_down     = 0.25;  // Gravity while falling (stronger = heavier feel)
max_fall      = 4.2;   // Maximum downward speed (prevents excessive fall velocity)
jump_speed    = -4.0;  // Initial vertical impulse (negative = upward motion)
jump_cut_mult = 0.6;   // Applied when jump key released early (creates short hop)


// ==========================================================
// === WALL MECHANICS ===
// ==========================================================
//
// Defines wall sliding and jumping behavior. Used to control
// the feel of wall interactions and responsiveness.
//

slide_speed     = 1.5; // Target fall speed when sliding on a wall
wall_jump_hsp   = 1.8; // Horizontal push when performing a wall jump
wall_jump_lock  = 6;   // Frames of horizontal input lock after wall jump


// ==========================================================
// === DOUBLE JUMP (CONFIG) ===
// ==========================================================
//
// Controls the number of allowed mid-air jumps. Reset each time
// the player touches the ground.
//

max_extra_jumps = 1;   // Allowed mid-air jumps (1 = double jump)


// ==========================================================
// === FORGIVENESS & INPUT BUFFERING ===
// ==========================================================
//
// Implements leniency for player input, improving responsiveness
// in jump timing (coyote time + jump buffer).
//

coyote_max  = 7;       // Frames allowed to jump after leaving ground
jumpbuf_max = 7;       // Frames to buffer jump input before landing


// ==========================================================
// === RUNTIME STATES ===
// ==========================================================
//
// Stores current physics, contact, and state variables.
// Updated dynamically during the Step event.
//

hsp = 0;               // Horizontal speed
vsp = 0;               // Vertical speed

on_ground = false;     // True when standing on solid ground
hit_head  = false;     // True when colliding with ceiling

touching_left  = false; // True if touching wall on the left side
touching_right = false; // True if touching wall on the right side
on_wall = false;        // True if sliding or sticking to a wall

wall_jump_timer = 0;    // Countdown for temporary horizontal input lock

coyote  = 0;           // Remaining frames of coyote time
jumpbuf = -1;          // Remaining frames of buffered jump input
extra_jumps = max_extra_jumps; // Remaining available air jumps

facing = 1;            // Facing direction (1 = right, -1 = left)