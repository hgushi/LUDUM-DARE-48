extends Node2D

var start_position = Vector2(0,0)
var scene : = ""

func end():
		get_tree().change_scene(scene)
		

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
