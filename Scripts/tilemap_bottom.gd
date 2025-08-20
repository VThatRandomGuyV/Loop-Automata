extends Node2D

@onready var tilemap: Node2D = $"."

func _set_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	
	#EVERYTHING RELATED TO TILEMAP BOTTOM SCREEN
	var tile_scale : float = (get_viewport_rect().size.x/1152)
	tilemap.scale = Vector2(tile_scale, tile_scale)
	tilemap.position.x = get_viewport_rect().size.x/2
	tilemap.position.y = get_viewport_rect().size.y - 55*tile_scale

func _process(delta):
	_set_position()
