extends Node2D

var level_n = 1
signal next_level

func _ready():
	$d_tutorial.visible = false

func _physics_process(delta):
	if $Player.d_charge == 1: $d_tutorial.visible = true

func end():
	$ColorRect.next_level(level_n)

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
