extends TextureRect
@onready var box: TextureRect = $"."
@onready var go: Sprite2D = $"../../Go"

var dragged_texture: Texture2D = null
@onready var lvl_actuel: Node2D = $"../.."

func _get_drag_data(at_position):
	if go.get_node("GoPlay").visible == false:
		if texture == null:
			return null

		if texture == preload("res://Assets/Actions/ATK_DEACT.png"):
			dragged_texture = preload("res://Assets/Actions/ATK_BOOK.png")
			lvl_actuel.box_act -= 1
		elif texture == preload("res://Assets/Actions/BLK_DEACT.png"):
			dragged_texture = preload("res://Assets/Actions/BLK_BOOK.png")
			lvl_actuel.box_act -= 1
		elif texture == preload("res://Assets/Actions/FWD_DEACT.png"):
			dragged_texture = preload("res://Assets/Actions/FWD_BOOK.png")
			lvl_actuel.box_act -= 1

		var preview_texture = TextureRect.new()
		preview_texture.texture = dragged_texture
		preview_texture.expand_mode = 1
		preview_texture.size = Vector2(96, 96)

		var preview = Control.new()
		preview.add_child(preview_texture)
		texture = preload("res://Assets/Actions/PRISE.png")
		set_drag_preview(preview)

		return dragged_texture

func _can_drop_data(_pos, data):
	if box.texture == preload("res://Assets/Actions/PRISE.png"):
		return data is Texture2D

func _drop_data(_pos, data):
	if data == preload("res://Assets/Actions/ATK_BOOK.png"):
		texture = preload("res://Assets/Actions/ATK_DEACT.png")
		lvl_actuel.box_act += 1
	elif data == preload("res://Assets/Actions/BLK_BOOK.png"):
		texture = preload("res://Assets/Actions/BLK_DEACT.png")
		lvl_actuel.box_act += 1
	elif data == preload("res://Assets/Actions/FWD_BOOK.png"):
		texture = preload("res://Assets/Actions/FWD_DEACT.png")
		lvl_actuel.box_act += 1

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if !get_viewport().gui_is_drag_successful() and dragged_texture:
			if dragged_texture == preload("res://Assets/Actions/ATK_BOOK.png"):
				texture = preload("res://Assets/Actions/ATK_DEACT.png")
				lvl_actuel.box_act += 1
			elif dragged_texture == preload("res://Assets/Actions/BLK_BOOK.png"):
				texture = preload("res://Assets/Actions/BLK_DEACT.png")
				lvl_actuel.box_act += 1
			elif dragged_texture == preload("res://Assets/Actions/FWD_BOOK.png"):
				texture = preload("res://Assets/Actions/FWD_DEACT.png")
				lvl_actuel.box_act += 1
		dragged_texture = null
