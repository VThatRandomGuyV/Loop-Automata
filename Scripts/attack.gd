extends Sprite2D

@export var attack_x : float = 75
@export var attack_y : float = 28
@export var rapetit : float = 1.2
var hover_factor : float = attack_y + 20

#ANIMATIONS
@onready var act_anim: AnimationPlayer = $"../ActionAnimations"

#COLLISION BOX
@onready var atk_colid: CollisionPolygon2D = $atk_area/AttackBox

#SRPITES
@onready var attack: Sprite2D = $"."
@onready var ref: Sprite2D = $"../Ref"

#SOUNDS
@onready var btn_hover: AudioStreamPlayer = $ButtonHover
@onready var pick_up: AudioStreamPlayer = $PickUp
@onready var drop: AudioStreamPlayer = $Drop

var selected : bool = false
var mouse_offset = Vector2(0, 0)
var hovering : bool = false

var atk_in : bool = false
var atk_out : bool = false

func _select_action():
	if selected:
		_follow_mouse()

func _follow_mouse():
	position = get_global_mouse_position() + mouse_offset

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if attack.visible == true:
				mouse_offset = position - get_global_mouse_position()
				selected = true
				act_anim.play("ShakeAttack")
				pick_up.play()
		else:
			selected = false
			hovering = false
			_set_position()
			act_anim.stop()

func _set_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)

	var want_width : float = ref.texture.get_width()
	var orig_width : float = attack.texture.get_width()
	var scale_ratio : float = want_width/orig_width
	
	attack.scale = Vector2(scale_ratio*scaling/rapetit, scale_ratio*scaling/rapetit)
	if hovering == false:
		attack.position.x = get_viewport_rect().size.x - (ref.texture.get_width()*scaling / 2) - attack_x*scaling
		attack.position.y = get_viewport_rect().size.y - (ref.texture.get_height()*scaling / 2) - attack_y*scaling

func _on_atk_area_mouse_entered() -> void:
	var scaling : float = (get_viewport_rect().size.x / 1920)

	var want_width : float = ref.texture.get_width()
	var orig_width : float = attack.texture.get_width()
	var scale_ratio : float = want_width/orig_width

	#attack.scale = Vector2(scale_ratio*scaling/1.5, scale_ratio*scaling/1.5)
	
	if not Input.is_action_just_pressed("lmb"):
		hovering = true
	else:
		hovering = false
	attack.position.x = get_viewport_rect().size.x - (ref.texture.get_width()*scaling / 2) - attack_x*scaling
	attack.position.y = get_viewport_rect().size.y - (ref.texture.get_height()*scaling / 2) - hover_factor*scaling
	btn_hover.play()

func _on_atk_area_mouse_exited() -> void:
	hovering = false

func _on_box_atk_in() -> void:
	atk_in = true
	atk_out = false

func _on_box_atk_out() -> void:
	atk_out = true
	atk_in = false

func _process(delta):
	_select_action()
	if selected == false:
		_set_position()
	if atk_in == true:
		_set_position()
		attack.visible = false
	if atk_out == true:
		_set_position()
		selected = true
		attack.visible = true
		atk_out = false
