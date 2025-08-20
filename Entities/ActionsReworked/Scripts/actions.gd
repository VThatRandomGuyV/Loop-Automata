extends TextureRect

@onready var box: TextureRect = $"../Box"
@onready var forward: TextureRect = $"."

var dragged_texture: Texture2D = null

func _get_drag_data(at_position):
	if texture == null:
		return null

	dragged_texture = texture

	var preview_texture = TextureRect.new()
	preview_texture.texture = dragged_texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(96, 96)

	var preview = Control.new()
	preview.add_child(preview_texture)
	texture = null
	set_drag_preview(preview)

	return dragged_texture

func _can_drop_data(_pos, data):
	return data is Texture2D

func _drop_data(_pos, data):
	if data == preload("res://Assets/Actions/ATK_BOOK.png") or data == preload("res://Assets/Actions/ATK_DEACT.png"):
		texture = preload("res://Assets/Actions/ATK_BOOK.png")
	elif data == preload("res://Assets/Actions/BLK_BOOK.png") or data == preload("res://Assets/Actions/BLK_DEACT.png"):
		texture = preload("res://Assets/Actions/BLK_BOOK.png")
	elif data == preload("res://Assets/Actions/FWD_BOOK.png") or data == preload("res://Assets/Actions/FWD_DEACT.png"):
		texture = preload("res://Assets/Actions/FWD_BOOK.png")

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if !get_viewport().gui_is_drag_successful() and dragged_texture:
			texture = dragged_texture
		dragged_texture = null
