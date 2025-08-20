extends Node2D

#SPRITES
@onready var player: Sprite2D = $Player
@onready var attack: Sprite2D = $Attack
@onready var forward: Sprite2D = $Forward
@onready var ref: Sprite2D = $Ref
@onready var tilemap: Node2D = $TilemapBottom

#IMPORTANT VARIABLES
var i : int = 1
@export var case_count : int = 7
@export var port_rect_h : float = 5.5
@export var nb_case : float = 2

func _draw():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	var screen_size = get_viewport_rect().size
	var rect_height : float = screen_size.y / port_rect_h
	var screen_length : float = screen_size.x
	var y_pos : float = screen_size.y - rect_height

	var line_spacing : float
#POSITION AND CREATION RECTANGLE BOTTOM
	var rect_position = Vector2(0, y_pos)
	var rect_size = Vector2(screen_length, rect_height)
	var rect_to_draw = Rect2(rect_position, rect_size)
	var grey_color = Color(0.5, 0.5, 0.5)
	draw_rect(rect_to_draw, grey_color)

	line_spacing = screen_length/case_count
	var line_x_position : float

	for i in range(case_count):
		line_x_position = (i+1) * line_spacing
		draw_line(Vector2(line_x_position, 0), Vector2(line_x_position, (y_pos)), Color(1, 1, 1), (2*scaling))

func _set_level_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	
	var want_width : float = ref.texture.get_width()
	var orig_width : float = player.texture.get_width()
	
	var scale_ratio = want_width / orig_width
	
	#EVERYTHING RELATED TO PLAYER POSITION AND SIZE
	player.scale = Vector2(scaling, scaling)
	player.position.x = get_viewport_rect().size.x / (case_count * 2)
	player.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((player.texture.get_height()*scaling) / 2)
	
	
func _ready():
	_draw()

func _process(delta):
	_set_level_position()
