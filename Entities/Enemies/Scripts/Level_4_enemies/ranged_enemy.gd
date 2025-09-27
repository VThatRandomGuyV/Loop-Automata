extends CharacterBody2D

@export var rg_case : int = 7

@onready var rg_enemy: CharacterBody2D = $"."
@onready var ref: Sprite2D = $"../Ref"
@onready var player: CharacterBody2D = $"../Player"
@onready var rg_sprite: Sprite2D = $Sprite2D/Sprite2D
@onready var rg_anim: AnimatedSprite2D = $Sprite2D/AnimatedSprite2D

@export var bullet_scene: PackedScene
@export var actions: Array[String] = ['', '', 'attack']

var target_distance := 0.0
var distance_moved := 0.0
var speed := 200
var direction := -1
var move := false
var current_action := 0
var case_count = 7

func _set_ranged_position():
	var scaling : float = (get_viewport_rect().size.x / 1152)
	
	var want_width : float = ref.texture.get_width()
	print(want_width)
	var orig_width : float = rg_sprite.texture.get_width()
	print(orig_width)
	
	var scale_ratio : float = want_width / orig_width
	print(scale_ratio)
	
	#EVERYTHING RELATED TO PLAYER POSITION AND SIZE
	var gros : float = 1
	rg_enemy.scale = Vector2(scaling*scale_ratio*gros*10, scaling*scale_ratio*gros*10)
	rg_enemy.position.x = get_viewport_rect().size.x / (case_count * 2) + (get_viewport_rect().size.x / case_count)*(rg_case-1)
	rg_enemy.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / player.port_rect_h))  - ((rg_sprite.texture.get_height()*scaling*scale_ratio*gros)/2)

func _ready() -> void:
	SignalBus.connect("take_turn", Callable(self, "_on_take_turn"))
	var screen_width = DisplayServer.window_get_size().x
	target_distance = screen_width / 7.0
	_set_ranged_position()
	rg_anim.play("Idle")

func _on_take_turn():
	match actions[current_action]:
		"move_left":
			move_left()
		"attack":
			attack()
	current_action = current_action + 1
	if current_action == actions.size():
		current_action = 0

func move_left() -> void:
	move = true
	direction = -1

func move_right() -> void:
	move = true
	direction = 1
	
func attack() -> void:
	if direction < 0:
		if bullet_scene:
			var bullet = bullet_scene.instantiate()
			get_tree().current_scene.add_child(bullet)
			bullet.global_position = global_position

func _on_area_entered(area: Area2D) -> void:
	SignalBus.emit_signal("player_hit")

func _physics_process(delta):
	if move:
		var step : float = min(speed * delta, target_distance - distance_moved)
		
		velocity.x = direction*step / delta  # convert back to per-second velocity
		move_and_slide()

		distance_moved += step

		if distance_moved >= target_distance:
			move = false
			distance_moved = 0
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		move = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		SignalBus.emit_signal("player_hit") 
