extends Node2D
@onready var atna: Node2D = $"."
@onready var ref: Sprite2D = $Ref
@onready var atna_1: Sprite2D = $Antena1
@onready var atna_2: Sprite2D = $Antena2
@onready var atna_3: Sprite2D = $Antena3
@onready var atna_4: Sprite2D = $Antena4
@onready var atna_5: Sprite2D = $Antena5
@onready var atna_6: Sprite2D = $Antena6
@onready var atna_7: Sprite2D = $Antena7

@export var case_count : int = 7
@export var port_rect_h : float = 5.5

var line_spacing : float

func _set_antenna_position():
	var scaling : float = (get_viewport_rect().size.x / 1920)
	
	var want_width : float = ref.texture.get_height()
	var orig_width : float = atna_1.texture.get_height()
	
	var scale_ratio = want_width / orig_width
	
	#EVERYTHING RELATED TO PLAYER POSITION AND SIZE
	var gros : float = 1
	atna_1.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	atna_2.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	atna_3.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	atna_4.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	atna_5.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	atna_6.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	atna_7.scale = Vector2(scaling*scale_ratio*gros, scaling*scale_ratio*gros)
	
	atna_1.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((atna_1.texture.get_height()*scaling*scale_ratio*gros) / 2)
	atna_2.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((atna_1.texture.get_height()*scaling*scale_ratio*gros) / 2)
	atna_3.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((atna_1.texture.get_height()*scaling*scale_ratio*gros) / 2)
	atna_4.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((atna_1.texture.get_height()*scaling*scale_ratio*gros) / 2)
	atna_5.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((atna_1.texture.get_height()*scaling*scale_ratio*gros) / 2)
	atna_6.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((atna_1.texture.get_height()*scaling*scale_ratio*gros) / 2)
	atna_7.position.y = (get_viewport_rect().size.y - (get_viewport_rect().size.y / port_rect_h)) - ((atna_1.texture.get_height()*scaling*scale_ratio*gros) / 2)
	
	
	atna_2.position.x = (get_viewport_rect().size.x / case_count)
	atna_3.position.x = (get_viewport_rect().size.x / case_count)*2
	atna_4.position.x = (get_viewport_rect().size.x / case_count)*3
	atna_5.position.x = (get_viewport_rect().size.x / case_count)*4
	atna_6.position.x = (get_viewport_rect().size.x / case_count)*5
	atna_7.position.x = (get_viewport_rect().size.x / case_count)*6
	
func _process(delta):
	_set_antenna_position()
