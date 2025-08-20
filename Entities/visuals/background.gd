extends Node2D

#BACKGROUND
@onready var background: Node2D = $"."

var i : int = 1
@export var case_count : int = 7
@export var port_rect_h : float = 6

func _set_back_position():
	var scaling : float = get_viewport_rect().size.x/1920
	background.scale = Vector2(scaling, scaling)
	background.position.x = 0
	background.position.y = 0

func _process(delta):
	_set_back_position()
