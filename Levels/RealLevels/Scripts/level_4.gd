extends Node2D
const LEVEL_5 = preload("uid://b7wxagy07gfvq")
@onready var boxes := 3
@export var time_between := 2
var box_act = 0

func _ready():
	SignalBus.connect("level_start", Callable(self,"_on_level_start"))
	SignalBus.connect("player_hit", Callable(self,"_on_player_hit"))

func _on_player_hit():
	get_tree().change_scene_to_file("res://Levels/RealLevels/level_4.tscn")

func _on_level_start():
	await get_tree().create_timer(0.1).timeout
	while true:
		SignalBus.emit_signal("take_turn")
		await get_tree().create_timer(time_between).timeout

func _on_area_2d_area_entered(area):
	if area.get_parent().name == "Player":
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(LEVEL_5)
