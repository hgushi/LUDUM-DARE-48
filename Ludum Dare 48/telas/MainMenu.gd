extends Control
#var scene : = "res://telas/SelectLevel.tscn"
#func _on_Controls_button_down():
#	$ControlMenu.visible = true
#func _on_QuitButton_button_down():
#	get_tree().quit()
#func _on_StartButton_button_down():
#	get_tree().change_scene(scene)

func _on_d_button_down():
	get_tree().change_scene("res://Levels/Level_D.tscn")
	
func _on_p_button_down():
	get_tree().change_scene("res://Levels/Level_P.tscn")

func _on_r_button_down():
	get_tree().change_scene("res://Levels/Level_R.tscn")

