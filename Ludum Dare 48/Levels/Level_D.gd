extends Node2D

var start_position = Vector2(0,0)
var scene : = ""

func end():
		get_tree().change_scene(scene)
		

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_P:
			if get_tree().paused == false:
				get_tree().paused = true
			else:
				get_tree().paused = false
				
