extends Node2D
@onready var swap: Sprite2D = $Swap
@onready var swap_lit: Sprite2D = $Swap/SwapLit
@onready var swap_unlit: Sprite2D = $Swap/SwapUnlit
@onready var swap_pressed: Sprite2D = $Swap/SwapPressed
@onready var timer: Timer = $Timer
@onready var go: Sprite2D = $Go
@onready var go_play: Sprite2D = $Go/GoPlay

@onready var boxes := 3
@export var time_between := 2
var box_act = 0
var reset_swap : bool = false
var timer_started : bool = false

func _ready():
	SignalBus.connect("level_start", Callable(self,"_on_level_start"))

func _on_level_start():
	await get_tree().create_timer(0.1).timeout
	while true:
		SignalBus.emit_signal("take_turn")
		await get_tree().create_timer(time_between).timeout

func _on_timer_timeout() -> void:
	swap_lit.visible = true
	swap_unlit.visible = false
	swap_pressed.visible = false

func _process(delta):
	if go_play.visible == true and timer_started == false:
		timer.wait_time = 2*boxes
		timer.start()
		timer_started = true
func _on_end_level_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.world.unload_level(5)
		Global.world.load_level(6)
