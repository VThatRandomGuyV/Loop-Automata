extends CharacterBody2D
@onready var p_anim: AnimatedSprite2D = $Sprite2D/p_anim
@onready var swap: Sprite2D = $"../Swap"
@onready var swap_pressed: Sprite2D = $"../Swap/SwapPressed"
@onready var swap_unlit: Sprite2D = $"../Swap/SwapUnlit"

@onready var hitbox_block_right: Area2D = $BlockRight
@onready var hitbox_block_right_shape: CollisionShape2D = $BlockRight/CollisionShape2D
@onready var hitbox_block_left: Area2D = $BlockLeft
@onready var hitbox_block_left_shape: CollisionShape2D = $BlockLeft/CollisionShape2D
@onready var hitbox_zap_right: Area2D = $ZapRight
@onready var hitbox_zap_right_shape: CollisionShape2D = $ZapRight/CollisionShape2D
@onready var hitbox_zap_left: Area2D = $ZapLeft
@onready var hitbox_zap_left_shape: CollisionShape2D = $ZapLeft/CollisionShape2D
@onready var ref: Sprite2D = $"../Ref"

@export var actions: Array[String] = []
@onready var p_sprite: Sprite2D = $Sprite2D/Sprite2D
@onready var player: CharacterBody2D = $"."

var i : int = 1
@export var case_count : int = 7
@export var port_rect_h : float = 5.5
var current_action : int = 0

var speed = 200
var moving = false
var target_distance_x := 0.0
var target_distance_y := 0.0
var distance_moved :=0.0
var direction :=1
var switched = false
var switch_height = 100 #to be adjusted
var gros : float = 1.5

var swapped : bool = true

func _ready() -> void:
	SignalBus.connect("switch_button", Callable(self,"switch"))
	SignalBus.connect("level_start", Callable(self, "_on_level_start"))
	SignalBus.connect("take_turn", Callable(self,"_on_take_turn"))
	SignalBus.connect("player_hit", Callable(self,"_on_player_hit"))
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y
	target_distance_x = screen_width / 7.0
	target_distance_y = screen_height / 2.0
	_set_level_position()
	p_anim.play("Idle")


func _set_level_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	
	var want_width : float = ref.texture.get_width()
	var orig_width : float = p_sprite.texture.get_width()
	
	var scale_ratio = want_width / orig_width
	
	#EVERYTHING RELATED TO PLAYER POSITION AND SIZE
	player.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	player.position.x = get_viewport_rect().size.x / (case_count * 2) + (get_viewport_rect().size.x / case_count)*0
	player.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((p_sprite.texture.get_height()*scaling*scale_ratio*gros) / 2)

	
func _on_take_turn():
	await get_tree().process_frame
	match actions[current_action]:
		"move_right":
			move_right()
		"block":
			block()
		"zap":
			zap()
	current_action = current_action + 1
	if current_action == actions.size():
		current_action = 0
		

func _on_level_start():
	await get_tree().process_frame
	for i in get_parent().boxes:
		var node_name := "Box%d"% [i + 1]
		if i == 0:
			node_name = "Box"
		var box := get_parent().get_node("SET AS UNIQUE").get_node(node_name)
		if(box.texture == preload("res://Assets/Actions/FWD_DEACT.png")):    # Check deactivated version
			actions.append("move_right")
			print("move")
		elif(box.texture == preload("res://Assets/Actions/ATK_DEACT.png")):  # Check deactivated version
			actions.append("zap")
			print("ZAP")
		elif(box.texture == preload("res://Assets/Actions/BLK_DEACT.png")):  # Check deactivated version
			actions.append("block")
			print("block")


func move_right() -> void:
	moving = true
	direction = 1

func move_left() -> void:
	moving = true
	direction = -1

func block() -> void:
	if direction>0:
		p_anim.play("Block")
		hitbox_block_right_shape.disabled = false
		await get_tree().create_timer(1).timeout
		hitbox_block_right_shape.disabled = true
	else:
		hitbox_block_left_shape.disabled = false
		await get_tree().create_timer(0.5).timeout
		hitbox_block_left_shape.disabled = true
		
		
func zap() -> void:
	if direction>0:
		p_anim.play("Attack")
		await get_tree().create_timer(0.02).timeout
		hitbox_zap_right_shape.disabled = false
		await get_tree().create_timer(1).timeout
		hitbox_zap_right_shape.disabled = true
	else:
		hitbox_zap_left_shape.disabled = false
		await get_tree().create_timer(0.5).timeout
		hitbox_zap_left_shape.disabled = true

func switch() -> void:
	if switched == false:
		global_position.y += switch_height
		switched = true
	else:
		global_position.y -= switch_height
		switched = false
	
func _physics_process(delta):
	if moving:
		var step : float = min(speed * delta, target_distance_x - distance_moved) #get_viewport_rect().size.x / case_count
		
		velocity.x = direction*step / delta  # convert back to per-second velocity
		move_and_slide()
		p_anim.play("Run")
		distance_moved += step

		if distance_moved >= target_distance_x:
			moving = false
			distance_moved = 0
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		moving=false
	
	if swap_pressed.visible == true and swapped == false or swap_unlit.visible == true and swapped == false:
		var scaling : float = (get_viewport_rect().size.x / 1920)
		var want_width : float = ref.texture.get_width()
		var orig_width : float = p_sprite.texture.get_width()
		var scale_ratio = want_width / orig_width
		player.position.y = target_distance_y+35 - p_sprite.texture.get_height()*scaling*scale_ratio*gros
	elif swap_pressed.visible == true and swapped == true or swap_unlit.visible == true and swapped == true:
		var scaling : float = (get_viewport_rect().size.x / 1920)
		var want_width : float = ref.texture.get_width()
		var orig_width : float = p_sprite.texture.get_width()
		var scale_ratio = want_width / orig_width
		player.position.y =  (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((p_sprite.texture.get_height()*scaling*scale_ratio*gros) / 2)

func _on_zap_right_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		print(area.name)
		area.get_parent().queue_free()
		
func _on_player_hit():
	_set_level_position()
