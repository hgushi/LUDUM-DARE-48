extends Control
var scene : = "res://Level_1.tscn"
func _on_Controls_button_down():
	$ControlMenu.visible = true
func _on_QuitButton_button_down():
	get_tree().quit()
func _on_StartButton_button_down():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)

