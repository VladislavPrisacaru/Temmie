function all_movement(){
	// call all the movement funcs
	simple_movement()
	handle_jumping()
	dash()
	wall_jump()
}

function simple_movement() {
	// left/right movement
	dir = (global.key_right - global.key_left)
	hsp = dir * move_spd;
	// apply gravity
	vsp += grav;
	
	if (dir != 0) {
		// get the last direction the player is facing
		last_direction = dir;
	}
}

function handle_jumping() {
	// all of th jumping
	if (place_meeting(x, y+1, oFloor)) && (global.key_space_pressed){
		vsp = jump_spd;
		can_double_jump = true;
		on_ground = false; 
		
	} else if (!global.key_space && vsp < 0) {
		// the more you press space the higher you jump
		vsp += 1.65;
	}
	
	else if (global.key_space_pressed && can_double_jump && !on_ground) {
		// apply double jump if player is in the air
		vsp = jump_spd;
		can_double_jump = false; // make sure the player can only double jump once
	}
	
	if (on_ground) {
		can_dash = true;
	}
}

function dash() {
	if (dash_timer > 0) { // start dash cooldown timer
		dash_timer -= 1;
	}
	
	if (global.key_dash && dash_timer <= 0 && can_dash) { // can dash check
	    if (global.touching_wall_left) { // if on the wall
	        hsp += (abs(last_direction) * dash_power); // allow to dash opposite of the wall
			dash_timer = dash_cooldown; // restart the cool down
			can_dash = true;
			air_dashed = false;
			
	    } else if (global.touching_wall_right) { // if on the wall
			hsp += (-abs(last_direction) * dash_power); // allow to dash opposite of the wall
			dash_timer = dash_cooldown; // restart the cool down
			can_dash = true;
			air_dashed = false;
			
	    } else { // normal dash
	        hsp += (last_direction * dash_power); 
			dash_timer = dash_cooldown;
			can_dash = true;
			air_dashed = false;
	    }
	}
}

function wall_jump() {
	global.touching_wall_left = place_meeting(x - 1, y, oWall); // self explainatory
	global.touching_wall_right = place_meeting(x + 1, y, oWall); // and again
	
	// check if the player is on the wall
	on_wall = (global.touching_wall_left || global.touching_wall_right) && !place_meeting(x, y + 1, oWall);
	
	if (on_wall && vsp > 0) { // wall slide
		vsp = lerp(vsp, wall_slide_spd, 0.3); // a smooth slide down
		wall_slide = true
		
	} else {
		wall_slide = false;
	}
	
	if (global.key_space_pressed && on_wall) {
		vsp = jump_spd * wall_jump_power; // jump from the wall
		
		if (global.touching_wall_left) {
        hsp = move_spd * wall_jump_speed; // that bounce from the wall just like in hollow knigh
		can_double_jump = true; // reset the double jump after the wall jump
		
		} else if (global.touching_wall_right) {
        hsp = -move_spd * wall_jump_speed; // same thing but the right wall
		can_double_jump = true;
		}
	}
}