extends Node2D

@onready var levels: Node2D = $LevelMarkers
@onready var loaded_levels: Node2D = $LoadedLevels

func _ready() -> void:
	Global.world = self
	load_level(1)

func unload_level(level_num: int):
	var node_name := "Level%s" % level_num
	var repeat_instance = null
	for level in Global.loaded_levels:
		if level.name == node_name:
			repeat_instance = level
			break
	if repeat_instance:
		if (is_instance_valid(repeat_instance)):
			Global.loaded_levels.erase(repeat_instance)
			repeat_instance.queue_free()

func load_level(level_num: int):
	print("tried loading lvel:", level_num)
	var node_name := "Level%s" % level_num
	print("tried loading lvel:", node_name)
	var repeat_instance = false
	for level in Global.loaded_levels:
		if level.name == node_name:
			repeat_instance = true
			break
	if not repeat_instance:
		var level_path_format := "res://Levels/RealLevels/level_%s.tscn"
		var level_path = level_path_format % level_num
		print(level_path)
		var level_resource := load(level_path)
		if (level_resource):
			var level_instance = level_resource.instantiate()
			level_instance.name = node_name
			level_instance.global_position = levels.find_child(node_name).global_position
			Global.loaded_levels.append(level_instance)
			loaded_levels.call_deferred("add_child", level_instance)
			print("loaded level: ", node_name)
