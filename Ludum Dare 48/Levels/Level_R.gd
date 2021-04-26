extends Node2D
var level_n = 1
signal next_level

func _ready():
	$tutorial.visible = false

func _physics_process(_delta):
	var player_p = weakref(get_node("Player_P/Player"))
	if not !player_p.get_ref():
		if player_p.get_ref().p_charge == 1: $tutorial.visible = true

#func end():
#	$ColorRect.next_level(level_n)

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

