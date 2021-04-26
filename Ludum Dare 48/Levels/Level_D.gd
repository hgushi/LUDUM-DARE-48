extends Node2D

var scene : = ""

func _ready():
	$d_tutorial.visible = false

func _physics_process(delta):
	if $Player.d_charge == 1: $d_tutorial.visible = true

func end():
		for i in range(0, 255, -1):
			modulate = Color(i, i, i, 255)
		get_tree().change_scene(scene)

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
