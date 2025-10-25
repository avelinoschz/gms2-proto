/// @desc Initialize player settings

#region Tunable Movement Settings
// Speed & cceleration
walk_speed      = 3.4;		// Max horizontal speed
accel_ground    = 1.8;		// Acceleration on ground (quick response)
accel_air       = 0.45;		// Acceleration mid-air (reduced control)
friction_ground = 0.75;		// Ground Friction Multiplier. Deceleration when no input (higher = stops faster)

// Jump & Gravity
grav            = 0.65;		// Gravity per frame
max_fall        = 9;		// Terminal velocity (limits fall speed)
jump_speed      = -8.5;		// Initial jump impulse (negative = upward)
jump_cut_mult   = 0.45;		// How much to cut velocity when releasing jump (short jumps)
#endregion

#region Forgiveness Windows
// Coyote time & Jump buffer
coyote_max      = 7;	// Frames allowed to jump after leaving ground
jumpbuf_max     = 7;	// Frames jump input can buffer before landing
#endregion

#region Runtime State Variables
hsp       = 0;			// Horizontal speed
vsp       = 0;			// Vertical speed
on_ground = false;		// True if touching ground
facing    = 1;			// 1=right, -1=left (for animations)
coyote    = 0;			// Counts down from coyote_max after leaving ground
jumpbuf   = -1;			// Counts down from jumpbuf_max after pressing jump (-1 = inactive)
#endregion

#region Collision settings
mask_inset      = 1;	// Pixel margin for clean corner collisions
#endregion
