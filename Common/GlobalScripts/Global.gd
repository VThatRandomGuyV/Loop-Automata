extends Node

var world
var loaded_levels: Array = []

#extends Node
#
#var world
#var loaded_levels: Array = []
#
#<<<<<<< Updated upstream
#var fwd1_selected = false
#var fwd2_selected = false
#
#var current_move = 1
#=======
#
##GEMINI
#var filled_boxes = 0
#var total_boxes = 0
#
#signal box_state_changed
#
#func register_box():
	#total_boxes += 1
	#update_start_button_state()
#
#func unregister_box():
	#total_boxes -= 1
	#update_start_button_state()
#
#func set_box_filled(is_filled: bool):
	#if is_filled:
		#filled_boxes += 1
	#else:
		#filled_boxes -= 1
	#update_start_button_state()
#
#func update_start_button_state():
	## Emit a signal so the Main scene can update the button
	#emit_signal("box_state_changed")
#
#func can_start():
	#return filled_boxes == total_boxes and total_boxes > 0
#>>>>>>> Stashed changes
