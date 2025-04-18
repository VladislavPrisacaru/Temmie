function all_movement(){
	simple_movement()
	handle_jumping()
	dash()
}

function simple_movement() {
	dir = (global.key_right - global.key_left)
	hsp = dir * move_spd;
	vsp += grav;
	
	if (dir != 0) {
		last_direction = dir;
	}
}

function handle_jumping() {
	if (place_meeting(x, y+1, oWall)) && (global.key_space_pressed){
		vsp = jump_spd;
		can_double_jump = true;
		on_ground = false; 
		
	} else if (!global.key_space && vsp < 0) {
		vsp += 1.65;
	}
	
	else if (global.key_space_pressed && can_double_jump && !on_ground) {
		vsp = jump_spd;
		can_double_jump = false;
	}
	
	if (on_ground) {
		can_dash = true;
	}
}

function dash() {
	if (dash_timer > 0) {
		dash_timer -= 1;
	}
	
	if (global.key_dash && dash_timer <= 0) {
		hsp += (last_direction * 100);
		dash_timer = dash_cooldown;
		can_dash = true;
		air_dashed = false; 
	}
}
