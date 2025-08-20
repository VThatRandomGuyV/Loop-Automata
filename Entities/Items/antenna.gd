extends Sprite2D
@onready var atna: Sprite2D = $"."
@onready var ref: Sprite2D = $Ref

@export var case_count : int = 7
@export var port_rect_h : float = 5.5

var line_spacing : float

func _set_antenna_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	
	var want_width : float = ref.texture.get_width()
	var orig_width : float = atna.texture.get_width()
	
	var scale_ratio = want_width / orig_width
	
	#EVERYTHING RELATED TO PLAYER POSITION AND SIZE
	var gros : float = 1
	atna.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)

func _process(delta):
	_set_antenna_position()
