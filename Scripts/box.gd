extends Sprite2D

@export var box_x : float = 125
@export var box_y : float = 10
@export var rapetit : float = 1.2

#SPRITES
@onready var box: Sprite2D = $"."
@onready var attack: Sprite2D = $"../Attack"
@onready var go_play: Sprite2D = $"../Go/GoPlay"
@onready var forward: Sprite2D = $"../Forward"
@onready var forward2: Sprite2D = $"../Forward2"

#SPRITES PRISE
	#FORWARD
@onready var fwd_deact: Sprite2D = $FwdDeact
@onready var fwd_deact_2: Sprite2D = $FwdDeact2
@onready var fwd_act: Sprite2D = $FwdActivated
@onready var fwd_deact_2: Sprite2D = $FwdDeact2
@onready var fwd_activated: Sprite2D = $FwdActivated
@onready var atk_activated: Sprite2D = $AtkActivated
@onready var blk_activated: Sprite2D = $BlkActivated

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
@onready var player: CharacterBody2D = $"../Player"

#SOUNDS
@onready var drop: AudioStreamPlayer = $Drop
@onready var pick_up: AudioStreamPlayer = $PickUp

#ANIMATIONS
@onready var act_anim: AnimationPlayer = $"../ActionAnimations"

#SIGNALS
signal fwd1_in
signal fwd2_in
signal atk_in
signal blk_in
signal fwd1_out
signal fwd2_out
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

var atk_colision : bool = false
var blk_colision : bool = false

var fwd1_detect : bool = false
var fwd2_detect : bool = false 

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
	if fwd1_detect == true and Input.is_action_just_released("lmb") and fwd_deact.visible == false and blk_deact.visible == false and fwd_deact.visible == false and fwd_deact_2.visible == false:
		fwd_deact.visible = true
		drop.play()
		forward.visible = false
		print("fwd_invis")
		fwd1_in.emit()
		box_act1.emit()
		box_act2.emit()
		box_act3.emit()
		fwd1_detect = false
	if fwd2_detect == true and Input.is_action_just_released("lmb")  and fwd_deact.visible == false and blk_deact.visible == false and fwd_deact.visible == false and fwd_deact_2.visible == false:
		fwd_deact_2.visible = true
		drop.play()
		forward2.visible = false
		print("fwd2_invis")
		fwd2_in.emit()
		box_act1.emit()
		box_act2.emit()
		box_act3.emit()
		fwd2_detect = false
	if atk_colision == true and Input.is_action_just_released("lmb") and fwd_deact.visible == false and blk_deact.visible == false and fwd_deact.visible == false and fwd_deact_2.visible == false:
		atk_deact.visible = true
		drop.play()
		atk_in.emit()
		box_act1.emit()
		box_act2.emit()
		box_act3.emit()
	if blk_colision == true and Input.is_action_just_released("lmb") and fwd_deact.visible == false and blk_deact.visible == false and fwd_deact.visible == false and fwd_deact_2.visible == false:
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
				if fwd1_detect == false and fwd_deact.visible == true:
					fwd_deact.visible = false
					forward._set_position()
					forward.visible = true
					forward.selected
				if fwd2_detect == false and fwd_deact_2.visible == true:
					fwd_deact_2.visible = false
					forward2._set_position()
					forward2.visible = true
					forward2.selected
				elif blk_deact.visible == true  or blk_act.visible == true:
					blk_out.emit()
					blk_deact.visible = false
				elif atk_deact.visible == true:
					atk_out.emit()
					atk_deact.visible = false
				box_deact1.emit()
				box_deact2.emit()
				box_deact3.emit()
				pick_up.play()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name == "Forward":
<<<<<<< Updated upstream
		fwd1_detect = false
	elif area.get_parent().name == "Forward2":
		fwd2_detect = false
=======
		fwd_colision = false
>>>>>>> Stashed changes
	elif area.get_parent().name == "Attack":
		atk_colision = false
	elif area.get_parent().name == "Block":
		blk_colision = false
	else:
		pass

func _on_area_2d_area_entered(area: Area2D):
	if area.get_parent().name == "Forward":
<<<<<<< Updated upstream
		fwd1_detect = true
	elif area.get_parent().name == "Forward2":
		fwd2_detect = true
=======
		fwd_colision = true
>>>>>>> Stashed changes
	elif area.get_parent().name == "Attack":
		atk_colision = true
	elif area.get_parent().name == "Block":
		blk_colision = true
	else:
		pass

func _ready():
	pass

func _process(delta):
	_droping_action()
	_set_box_position()
