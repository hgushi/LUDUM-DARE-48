extends Node2D

func _ready():
	get_node("CanvasLayer").get_node("PauseMenu").visible = false
	get_node("CanvasLayer").get_node("WinScene").visible = false
	get_node("CanvasLayer").get_node("LoseScene").visible = false
	
func death():
	get_node("CanvasLayer/LoseScene").visible = true
	get_node("CanvasLayer/LoseScene/LoseMusic").play()
