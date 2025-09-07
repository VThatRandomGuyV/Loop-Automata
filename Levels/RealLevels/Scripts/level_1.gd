extends Node2D

@onready var boxes := 2
@export var time_between := 2
var box_act = 0

func _ready():
	SignalBus.connect("level_start", Callable(self,"_on_level_start"))
	
func _on_level_start():
	await get_tree().create_timer(0.1).timeout
	while true:
		SignalBus.emit_signal("take_turn")
		await get_tree().create_timer(time_between).timeout

func _on_end_level_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.world.unload_level(1)
		Global.world.load_level(2)
