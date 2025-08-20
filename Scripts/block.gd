extends Sprite2D

@export var block_x : float = 129
@export var block_y : float = 25
@export var rapetit : float = 1.2
var hover_factor : float = block_y + 20

#ANIMATIONS
@onready var act_anim: AnimationPlayer = $"../ActionAnimations"

#SPRITES
@onready var ref: Sprite2D = $"../Ref"
@onready var block: Sprite2D = $"."

#SOUNDS
@onready var btn_hover: AudioStreamPlayer = $ButtonHover
@onready var pick_up: AudioStreamPlayer = $PickUp
@onready var drop: AudioStreamPlayer = $Drop

var selected : bool = false
var mouse_offset = Vector2(0, 0)
var hovering : bool = false

var blk_in : bool = false
var blk_out : bool = false

func _select_action():
	if selected:
		_follow_mouse()

func _follow_mouse():
	position = get_global_mouse_position() + mouse_offset

func _on_blk_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if block.visible == true:
				mouse_offset = position - get_global_mouse_position()
				selected = true
				act_anim.play("ShakeBlock")
				pick_up.play()
		else:
			selected = false
			hovering = false
			_set_position()
			act_anim.stop()

func _set_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)

	var want_width : float = ref.texture.get_width()
	var orig_width : float = block.texture.get_width()
	var scale_ratio : float = want_width/orig_width
	
	block.scale = Vector2(scale_ratio*scaling/rapetit, scale_ratio*scaling/rapetit)
	if hovering == false:
		block.position.x = get_viewport_rect().size.x - (ref.texture.get_width()*scaling / 2) - (ref.texture.get_width()*scaling*2) - block_x*scaling
		block.position.y = get_viewport_rect().size.y - (ref.texture.get_height()*scaling / 2) - block_y*scaling

func _on_blk_area_mouse_entered() -> void:
	var scaling : float = (get_viewport_rect().size.x / 1920)

	var want_width : float = ref.texture.get_width()
	var orig_width : float = block.texture.get_width()
	var scale_ratio : float = want_width/orig_width

	#block.scale = Vector2(scale_ratio*scaling, scale_ratio*scaling)
	hovering = true
	block.position.x = get_viewport_rect().size.x - (ref.texture.get_width()*scaling / 2) - (ref.texture.get_width()*scaling*2) - block_x*scaling
	block.position.y = get_viewport_rect().size.y - (ref.texture.get_height()*scaling / 2) - hover_factor*scaling
	btn_hover.play()

func _on_blk_area_mouse_exited() -> void:
	hovering = false

func _on_box_blk_in() -> void:
	blk_in = true
	blk_out = false

func _on_box_blk_out() -> void:
	blk_in = false
	blk_out = true

func _process(delta):
	_select_action()
	if selected == false:
		_set_position()
	if blk_in == true:
		_set_position()
		block.visible = false
	if blk_out == true:
		_set_position()
		selected = true
		block.visible = true
		blk_out = false
