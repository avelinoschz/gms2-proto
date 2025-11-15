var next_room = room_next(room);  // get the next room in resource order

if (next_room != -1) {
    // There is another room, go to it
    room_goto(next_room);
} else {
    // No more rooms (this is the last one)
	// room_goto(rm_victory);  // or any "end" screen
	
	game_restart(); // For now, the game restarts
}