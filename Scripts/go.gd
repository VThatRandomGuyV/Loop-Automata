extends Sprite2D
@onready var lvl_actuel: Node2D = $".."

#SPRITES
@onready var go: Sprite2D = $"."
@onready var ref: Sprite2D = $"../Ref"
@onready var go_lit: Sprite2D = $GoLit
@onready var go_play: Sprite2D = $GoPlay

#SOUNDS
@onready var btn_hover: AudioStreamPlayer = $Sounds/ButtonHover
@onready var btn_press: AudioStreamPlayer = $Sounds/ButtonPress
@onready var go_ready: AudioStreamPlayer = $Sounds/GoReady
var rdy : bool = false

var rapetit : float = 1.5

var box1_act : bool = false
var box2_act : bool = false
var box3_act : bool = false

func _set_go_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	var want_height : float = ref.texture.get_height()
	var orig_height : float = go.texture.get_height()
	
	var height_ratio : float = want_height/orig_height
	
	go.scale = Vector2(height_ratio*scaling/rapetit, height_ratio*scaling/rapetit)
	
	go.position.x = ((get_viewport_rect().size.x) - (go.texture.get_width()*height_ratio*scaling/(2*rapetit)))
	go.position.y = go.texture.get_height()*height_ratio*scaling/(2*rapetit)


func _verif_activ():
	if lvl_actuel.box_act == lvl_actuel.boxes:
		go_lit.visible = true
	else:
		go_lit.visible = false
		rdy = true

func _ready():
	go_lit.visible = false
	go_play.visible = false

func _process(delta):
	if rdy == true and box2_act == true and box1_act == true and box3_act == true:
		go_ready.play()
		rdy = false
	_set_go_position()
	_verif_activ()

func _on_go_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if go_lit.visible == true:
				go_lit.visible = false
				go_play.visible = true
				btn_press.play()
				SignalBus.emit_signal("level_start")
		else:
			pass


func _on_go_area_mouse_entered() -> void:
	go.modulate = Color(0.5, 0.5, 0.5)
	btn_hover.play()

func _on_go_area_mouse_exited() -> void:
	go.modulate = Color(1, 1, 1)
