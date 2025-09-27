extends Control
const LEVEL_TUTORIAL = preload("uid://bkb58pbb1j6wn")
const LEVEL_1 = preload("uid://e2pvpaokk48b")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_1)
	$VBoxContainer/Button_Click.play()
	MusicControl._play_music()


func _on_tutorial_pressed() -> void:
	$VBoxContainer/Button_Click.play()
	get_tree().change_scene_to_packed(LEVEL_TUTORIAL)
	MusicControl._play_music()

func _on_play_mouse_entered() -> void:
	$VBoxContainer/Button_hover.play()


func _on_tutorial_mouse_entered() -> void:
	$VBoxContainer/Button_hover.play()
