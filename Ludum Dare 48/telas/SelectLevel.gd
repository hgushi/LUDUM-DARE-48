extends Control
var scene1 : = "res://Levels/Level_D.tscn"
var scene2: = ""
var scene3: = ""


var level: int = 0
func load_game():
	var save_file : File = File.new()
	var erro: = save_file.open("res://Save/save.res",File.READ)
	var dados_salvos = save_file.get_var()
	if not erro:
			level = dados_salvos["level"]
func _ready ():
	load_game()
	var level2 = get_node("HBoxContainer").get_node("Level2")
	var level3 = get_node("HBoxContainer").get_node("Level3")
	level2.visible = false
	level3.visible = false

	if level >= 2:
		$Blocked2.visible = false
		level2.visible = true
	if level >= 3:
		$Blocked3.visible = false
		level3.visible = true

func _on_Level1_button_down():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene1)

func _on_Level2_button_down():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene2)

func _on_Level3_button_down():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene3)

