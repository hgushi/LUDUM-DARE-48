extends ColorRect

# Path to the next scene to transition to
export(String, FILE, "*.tscn") var next_scene_path

var levels = ["res://Levels/Level_D.tscn", "res://Levels/Level_P.tscn", "res://Levels/Level_R.tscn"]

func _ready() -> void:
	# Plays the animation backward to fade in
	$AnimationPlayer.play_backwards("Fade")

func transition_to(_next_scene := next_scene_path) -> void:
	# Plays the Fade animation and wait until it finishes
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer, "animation_finished")
	# Changes the scene
	get_tree().change_scene(_next_scene)

func next_level(level_n) -> void:
	transition_to(levels[level_n + 1])
