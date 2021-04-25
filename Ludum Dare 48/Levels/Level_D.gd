extends Node2D

var checkpoint = Vector2(0,0)

func _ready():
	get_node("CanvasLayer").get_node("PauseMenu").visible = false
	get_node("CanvasLayer").get_node("WinScene").visible = false
	get_node("CanvasLayer").get_node("LoseScene").visible = false
	checkpoint = $Player_D.position
	
func death():
	$Player_D.position = checkpoint
