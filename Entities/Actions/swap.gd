extends Sprite2D
@onready var swap_unlit: Sprite2D = $SwapUnlit
@onready var swap_pressed: Sprite2D = $SwapPressed
@onready var swap_lit: Sprite2D = $SwapLit
@onready var btn_hover: AudioStreamPlayer = $ButtonHover
@onready var ref: Sprite2D = $"../Ref"
@onready var swap: Sprite2D = $"."
@onready var btn_press: AudioStreamPlayer = $ButtonPress

@export var swap_x : float = 940
@export var swap_y : float = 25

func _ready():
	swap_lit.visible = true
	swap_unlit.visible = false
	swap_pressed.visible = false

func _on_swap_colid_mouse_entered() -> void:
	swap.modulate = Color(0.5, 0.5, 0.5)
	btn_hover.play()

func _on_swap_colid_mouse_exited() -> void:
	swap.modulate = Color(1, 1, 1)



func _set_swap_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	var want_height : float = ref.texture.get_height()
	var orig_height : float = swap_lit.texture.get_height()
	
	var height_ratio : float = want_height/orig_height
	var rapetit : float = 1.15
	
	swap.scale = Vector2(height_ratio*scaling/rapetit, height_ratio*scaling/rapetit)
	
	swap.position.x = get_viewport_rect().size.x - (ref.texture.get_width()*scaling / 2) - swap_x*scaling
	swap.position.y = get_viewport_rect().size.y - (ref.texture.get_height()*scaling / 2) - swap_y*scaling

func _process(delta):
	_set_swap_position()


func _on_swap_colid_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if swap_lit.visible == true:
				swap_lit.visible = false
				swap_pressed.visible = true
				btn_press.play()
				await get_tree().create_timer(0.5).timeout
				swap_unlit.visible = true
				swap_pressed.visible = false
