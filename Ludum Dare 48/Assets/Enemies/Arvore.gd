extends Area2D
class_name Arvore
var raio_de_alcance = 50
var intervalo_de_ataque = 1
var player_alvo = weakref(null)
onready var AtaqueTimer: = $AtaqueTimer

func _ready():
	get_node("Alcance").shape.set_radius(raio_de_alcance)
	AtaqueTimer.wait_time = intervalo_de_ataque
	
func _physics_process(_delta):
	set_target()
		
func set_target():
	if !player_alvo.get_ref():
		AtaqueTimer.stop()
		for area in get_overlapping_areas():
			if area.is_in_group("player"):
				if !player_alvo.get_ref() or area.get_parent().offset > player_alvo.get_ref().offset:
					player_alvo = weakref(area.get_parent())
	if AtaqueTimer.is_stopped() and not !player_alvo.get_ref():
		AtaqueTimer.start()
		


func _on_AtaqueTimer_timeout():
	pass # Replace with function body.


func _on_Arvore_area_exited(area):
	if area.get_parent() == player_alvo.get_ref(): player_alvo = weakref(null)
	if area.is_in_group("7"):
		area.queue_free()
