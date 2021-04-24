extends Control
var scene1 : = ""
var scene2: = ""
var scene3: = ""
var scene4: = ""
var scene5: = ""
var scene6: = ""


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
	var level4 = get_node("HBoxContainer2").get_node("Level4")
	var level5 = get_node("HBoxContainer2").get_node("Level5")
	var level6 = get_node("HBoxContainer2").get_node("Level6")
	level2.visible = false
	level3.visible = false
	level4.visible = false
	level5.visible = false
	level6.visible = false

	if level >= 2:
		$Blocked2.visible = false
		level2.visible = true
	if level >= 3:
		$Blocked3.visible = false
		level3.visible = true
	if level >= 4:
		$Blocked4.visible = false
		level4.visible = true
	if level >= 5:
		$Blocked5.visible = false
		level5.visible = true
	if level >= 6:
		$Blocked6.visible = false
		level6.visible = true

func _on_Level1_button_down():
	get_tree().change_scene(scene1)

func _on_Level2_button_down():
	get_tree().change_scene(scene2)

func _on_Level3_button_down():
	get_tree().change_scene(scene3)

func _on_Level4_button_down():
	get_tree().change_scene(scene4)

func _on_Level5_button_down():
	get_tree().change_scene(scene5)

func _on_Level6_button_down():
	get_tree().change_scene(scene6)
