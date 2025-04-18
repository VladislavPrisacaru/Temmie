function collisions(){
	if (place_meeting(x+hsp, y, oWall)) || (place_meeting(x+hsp, y, oFloor)) {
		while (!place_meeting(x+sign(hsp), y, oWall)) && (!place_meeting(x+sign(hsp), y, oFloor)) {
			x += sign(hsp); 
		}
		hsp = 0; 
	}
	
	if (place_meeting(x, y+vsp, oWall)) || (place_meeting(x, y+vsp, oFloor)) {
		while (!place_meeting(x, y+sign(vsp), oWall)) && (!place_meeting(x, y+sign(vsp), oFloor)) {
			y += sign(vsp);
		}
		vsp = 0; 
	}

	x += hsp;
	y += vsp;
}