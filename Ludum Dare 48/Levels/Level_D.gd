extends Node2D

var start_position = Vector2(0,0)

func _ready():
	get_node("CanvasLayer").get_node("PauseMenu").visible = false
	get_node("CanvasLayer").get_node("WinScene").visible = false
	get_node("CanvasLayer").get_node("LoseScene").visible = false
	
func death():
	get_tree().reload_current_scene()
