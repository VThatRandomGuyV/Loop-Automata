extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/RealLevels/level_1.tscn")
	$VBoxContainer/Button_Click.play()


func _on_tutorial_pressed() -> void:
	$VBoxContainer/Button_Click.play()


func _on_play_mouse_entered() -> void:
	$VBoxContainer/Button_hover.play()


func _on_tutorial_mouse_entered() -> void:
	$VBoxContainer/Button_hover.play()
