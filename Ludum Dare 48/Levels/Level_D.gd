extends Node2D

var scene : = ""

func end():
		for i in range(0, 255, -1):
			modulate = Color(i, i, i, 255)
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
				
