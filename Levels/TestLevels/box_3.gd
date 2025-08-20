extends Sprite2D

@export var box_x : float = 125
@export var box_y : float = 10
@export var rapetit : float = 1.2

#SPRITES
@onready var box: Sprite2D = $"."
@onready var attack: Sprite2D = $"../Attack"
@onready var go_play: Sprite2D = $"../Go/GoPlay"

#SPRITES PRISE
	#FORWARD
@onready var fwd_deact: Sprite2D = $FwdDeact
@onready var fwd_act: Sprite2D = $FwdActivated

	#ATTACK
@onready var atk_deact: Sprite2D = $AtkDeact
@onready var atk_act: Sprite2D = $AtkActivated

	#BLOCK
@onready var blk_deact: Sprite2D = $BlkDeact
@onready var blk_act: Sprite2D = $BlkActivated

#COLLIDERS
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var attack_colid: CollisionShape2D = $Area2D/AttackBox

#AREAS
@onready var fwd_area: Area2D = $fwd_area
@onready var atk_area: Area2D = $atk_area
@onready var box_area : Area2D = $box_area

#SOUNDS
@onready var drop: AudioStreamPlayer = $Drop
@onready var pick_up: AudioStreamPlayer = $PickUp

#SIGNALS
signal fwd_in
signal atk_in
signal blk_in
signal fwd1_in
signal fwd2_in
signal fwd3_in

signal fwd1_out
signal fwd2_out
signal fwd3_out
signal atk_out
signal blk_out

signal box_act1
signal box_deact1

signal box_act2
signal box_deact2

signal box_act3
signal box_deact3

#REFERENCE !!!VERY IMPORTANT - DO NOT TOUCH!!!
@onready var ref: Sprite2D = $"../Ref"

var fwd_colision : bool = false
var atk_colision : bool = false
var blk_colision : bool = false

func _set_box_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	var want_width : float = ref.texture.get_width() + 18
	var orig_width : float = box.texture.get_width()
	
	var width_ratio : float = want_width/orig_width
	
	var want_height : float = ref.texture.get_height() + 18
	var orig_height : float = box.texture.get_height()
	
	var height_ratio : float = want_height/orig_height
	
	box.scale = Vector2(width_ratio*scaling/rapetit, height_ratio*scaling/rapetit)
	
	box.position.x = ((box.texture.get_width()*width_ratio*scaling + box_x*scaling)/2)
	box.position.y = get_viewport_rect().size.y - ((box.texture.get_height()*height_ratio*scaling/2) + box_y*scaling)

func _all_invisible():
	fwd_deact.visible = false
	blk_deact.visible = false
	atk_deact.visible = false
	fwd_act.visible = false
	atk_act.visible = false
	blk_act.visible = false

func _droping_action():
	if fwd_colision == true and Input.is_action_just_released("lmb") and blk_deact.visible == false and atk_deact.visible == false:
		_all_invisible()
		fwd_deact.visible = true
		drop.play()
		if Global.current_move == 1:
			fwd1_in.emit()
			Global.current_move += 1
		elif Global.current_move == 2:
			fwd2_in.emit()
			Global.current_move += 1
		elif Global.current_move == 3:
			fwd3_in.emit()
			Global.current_move += 1
		box_act1.emit()
		box_act2.emit()
		box_act3.emit()
	if atk_colision == true and Input.is_action_just_released("lmb") and blk_deact.visible == false and fwd_deact.visible == false:
		_all_invisible()
		atk_deact.visible = true
		drop.play()
		atk_in.emit()
		box_act1.emit()
		box_act2.emit()
		box_act3.emit()
	if blk_colision == true and Input.is_action_just_released("lmb") and fwd_deact.visible == false and atk_deact.visible == false:
		_all_invisible()
		blk_deact.visible = true
		drop.play()
		blk_in.emit()
		box_act1.emit()
		box_act2.emit()
		box_act3.emit()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if go_play.visible == false:
				if fwd_act.visible == true or fwd_deact.visible == true:
					if Global.current_move == 2:
						fwd1_out.emit()
						Global.current_move -= 1
					elif Global.current_move == 3:
						fwd2_out.emit()
						Global.current_move -= 1
					elif Global.current_move == 4:
						fwd3_out.emit()
						Global.current_move -= 1
				elif blk_deact.visible == true  or blk_act.visible == true:
					blk_out.emit()
				elif atk_act.visible == true  or atk_deact.visible == true:
					atk_out.emit()
				_all_invisible()
				box_deact1.emit()
				box_deact2.emit()
				box_deact3.emit()
				pick_up.play()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "fwd_area":
		fwd_colision = false
	elif area.name == "atk_area":
		atk_colision = false
	elif area.name == "blk_area":
		blk_colision = false
	else:
		pass

func _on_area_2d_area_entered(area: Area2D):
	if area.name == "fwd_area":
		fwd_colision = true
	elif area.name == "atk_area":
		atk_colision = true
	elif area.name == "blk_area":
		blk_colision = true
	else:
		pass

func _ready():
	pass

func _process(delta):
	_droping_action()
	_set_box_position()
