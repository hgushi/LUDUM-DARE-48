extends KinematicBody2D

#var speed : = Vector2(0,1000)
var velocity: = Vector2(0,0)
var direction
#var gravity: = 300.0

var bomba = load("res://Assets/Enemies/6.tscn")

func _on_AtaqueTimer_timeout():
	var projetil = bomba.instance()
	if rotation > 0: projetil.direction = Vector2(cos(rotation), - sin(rotation))
	else: projetil.direction = Vector2(- cos(rotation), sin(rotation))
	projetil.scale = Vector2(0.3, 0.3)
	self.add_child(projetil)

func _on_VisibilityNotifier2D_screen_entered():
	$AtaqueTimer.start()

#func _ready():
#	set_physics_process(false)
#
#func _physics_process(delta):
#	position += velocity*delta
#
#func _on_Area2D_body_entered(_body):
#	velocity = speed
#	velocity.y += gravity*get_process_delta_time()
