extends Node
@onready var music_game: AudioStreamPlayer = $MusicGame
@onready var button_hover: AudioStreamPlayer = $ButtonHover
@onready var button_press: AudioStreamPlayer = $ButtonPress
@onready var go_ready: AudioStreamPlayer = $GoReady
@onready var pick_up: AudioStreamPlayer = $PickUp

func _play_music():
	music_game.play()
func _butt_hover():
	button_hover.play()
func _butt_press():
	button_press.play()
func _pick_up():
	pick_up.play()
