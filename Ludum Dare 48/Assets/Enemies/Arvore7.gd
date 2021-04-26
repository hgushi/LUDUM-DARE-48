extends Area2D

var bomerangue = load("res://Assets/Enemies/7.tscn")
var player

func _ready():
	player = get_parent().get_node("Player_D")

func _on_AtaqueTimer_timeout():
	var i = 0
	var rotation = 0
		
	while i <= 8:
		rotation += PI/4 * i

		var projetil = bomerangue.instance()
		projetil.direction = Vector2(cos(rotation), sin(rotation))
		self.add_child(projetil)
		
		i += 1
#
#func _on_Arvore7_area_exited(area):
##	if area.get_parent() == player_alvo.get_ref(): player_alvo = weakref(null)
#	if area.is_in_group("7"):
#		area.queue_free()

func _on_VisibilityNotifier2D_screen_entered():
	$AtaqueTimer.start()
