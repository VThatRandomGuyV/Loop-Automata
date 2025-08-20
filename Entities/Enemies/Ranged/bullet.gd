extends Area2D

var delete := false


func _ready():
	# Connect to area entered signal for collision detection
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("body_entered", Callable(self, "_on_body_entered"))
	SignalBus.connect("take_turn", Callable(self, "_on_take_turn"))

func _on_take_turn():
	delete = true
	if delete:
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		SignalBus.emit_signal("player_hit")   # Replace with function body.
