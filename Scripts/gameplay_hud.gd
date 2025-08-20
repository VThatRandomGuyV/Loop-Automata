extends Control
@onready var tile_bottom: Control = $"."

func process(delta):
	if get_viewport_rect().size.x == 1920:
		tile_bottom.scale.x = 1.66666
		tile_bottom.scale.y = 1.66666
	else:
		tile_bottom.scale = Vector2(1, 1)
