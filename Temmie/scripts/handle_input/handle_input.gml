function handle_input(){
	// virtual keys
	global.key_left = keyboard_check(ord("A"));
	global.key_right = keyboard_check(ord("D"));
	global.key_space = keyboard_check(vk_space);
	global.key_space_pressed = keyboard_check_pressed(vk_space);
	global.key_dash = keyboard_check(vk_shift)
} 