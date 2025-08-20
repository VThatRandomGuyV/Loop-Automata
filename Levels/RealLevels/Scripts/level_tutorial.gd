extends Node2D

@onready var boxes := 1
@export var time_between := 2
var box_act = 0

func _ready():
	SignalBus.connect("level_start", Callable(self,"_on_level_start"))
	
func _on_level_start():
	await get_tree().create_timer(0.1).timeout
	while true:
		SignalBus.emit_signal("take_turn")
		await get_tree().create_timer(time_between).timeout
