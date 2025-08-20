extends Sprite2D

@export var forward_x : float = 102
@export var forward_y : float = 27
@export var rapetit : float = 1.2
var hover_factor : float = forward_y + 20

#ANIMATIONS
@onready var act_anim: AnimationPlayer = $"../ActionAnimations"

#SPRITES
@onready var forward: Sprite2D = $"."
@onready var forward2: Sprite2D = $"../Forward2"
@onready var ref: Sprite2D = $"../Ref"
@onready var go_play: Sprite2D = $GoPlay

#SOUNDS
@onready var btn_hover: AudioStreamPlayer = $ButtonHover
@onready var pick_up: AudioStreamPlayer = $PickUp
@onready var drop: AudioStreamPlayer = $Drop

var mouse_offset = Vector2(0, 0)
var hovering : bool = false
var selected = false
var fwd_in : bool = false
var fwd_out : bool = false

func _select_action():
	if selected:
		_follow_mouse()

func _follow_mouse():
	position = get_global_mouse_position() + mouse_offset

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if forward2.visible == true:
				mouse_offset = position - get_global_mouse_position()
				selected = true
				act_anim.play("ShakeForward2")
				pick_up.play()
		else:
			selected = false
			hovering = false
			act_anim.stop()
			_set_position()

func _set_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	
	var want_width : float = ref.texture.get_width()
	var orig_width : float = forward.texture.get_width()
	var scale_ratio : float = want_width/orig_width
	
	forward.scale = Vector2(scale_ratio*scaling/rapetit, scale_ratio*scaling/rapetit)
	if hovering == false:
		forward.position.x = get_viewport_rect().size.x - (ref.texture.get_width()*scaling / 2) - ref.texture.get_width()*scaling - forward_x*scaling
		forward.position.y = get_viewport_rect().size.y - (ref.texture.get_height()*scaling / 2) - forward_y*scaling

func _on_fwd_area_mouse_entered() -> void:
	var scaling : float = (get_viewport_rect().size.x / 1920)

	var want_width : float = ref.texture.get_width()
	var orig_width : float = forward.texture.get_width()
	var scale_ratio : float = want_width/orig_width

	#forward.scale = Vector2(scale_ratio*scaling, scale_ratio*scaling)
	
	if not Input.is_action_just_pressed("lmb"):
		hovering = true
	else:
		hovering = false
	forward.position.x = get_viewport_rect().size.x - (ref.texture.get_width()*scaling / 2) - ref.texture.get_width()*scaling - forward_x*scaling
	forward.position.y = get_viewport_rect().size.y - (ref.texture.get_height()*scaling / 2) - hover_factor*scaling
	btn_hover.play()

func _on_fwd_area_mouse_exited() -> void:
	hovering = false

func _on_box_fwd_2_in() -> void:
	fwd_in = true
	fwd_out = false

func _on_box_fwd_2_out() -> void:
	fwd_out = true
	fwd_in = false

func _process(delta):
	_select_action()
	if selected == false:
		_set_position()
