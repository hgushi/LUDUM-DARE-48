extends Node2D

var level_n = 1
signal next_level

func _ready():
	$tutorial.visible = false

func _physics_process(delta):
	if $Player.p_charge == 1: $tutorial.visible = true

func end():
	$ColorRect.next_level(level_n)

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
