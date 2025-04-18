function all_movement(){
	simple_movement()
	handle_jumping()
	dash()
	wall_jump()
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
	if (place_meeting(x, y+1, oFloor)) && (global.key_space_pressed){
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
	
	if (global.key_dash && dash_timer <= 0 && can_dash) {
	    if (global.touching_wall_left) {
	        hsp += (abs(last_direction) * dash_power);
			dash_timer = dash_cooldown;
			can_dash = true;
			air_dashed = false;
			
	    } else if (global.touching_wall_right) {
			hsp += (-abs(last_direction) * dash_power);
			dash_timer = dash_cooldown;
			can_dash = true;
			air_dashed = false;
			
	    } else {
	        hsp += (last_direction * dash_power);
			dash_timer = dash_cooldown;
			can_dash = true;
			air_dashed = false;
	    }
	}
}

function wall_jump() {
	global.touching_wall_left = place_meeting(x - 1, y, oWall);
	global.touching_wall_right = place_meeting(x + 1, y, oWall);
	
	on_wall = (global.touching_wall_left || global.touching_wall_right) && !place_meeting(x, y + 1, oWall);
	
	if (on_wall && vsp > 0) {
		vsp = lerp(vsp, wall_slide_spd, 0.3);
		wall_slide = true
		
	} else {
		wall_slide = false;
	}
	
	if (global.key_space_pressed && on_wall) {
		vsp = jump_spd * wall_jump_power;
		
		if (global.touching_wall_left) {
        hsp = move_spd * wall_jump_speed; 
		can_double_jump = true;
		
		} else if (global.touching_wall_right) {
        hsp = -move_spd * wall_jump_speed;
		can_double_jump = true;
		}
	}
}