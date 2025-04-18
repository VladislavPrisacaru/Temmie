function all_movement(){
	simple_movement()
	handle_jumping()
	dash()
}

function simple_movement() {
	dir = (global.key_right - global.key_left)
	hsp = dir * move_spd;
	vsp += grav;
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
}

function dash() {
	if (dash_timer > 0) {
		dash_timer -= 1;
	}
	
	if (global.key_dash && dash_timer <= 0) {
		if (on_ground) {
		hsp += (sign(hsp) * 100);
		dash_timer = dash_cooldown;
		can_dash = true;
		air_dashed = false; 
			
		} else if (!on_ground && !air_dashed) {
			hsp += (sign(hsp) * 100);
			dash_timer = dash_cooldown;
			air_dashed = true;
			can_dash = false;
		}
	}
}
