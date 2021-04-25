extends KinematicBody2D

var speed : = Vector2(0,1000)
var velocity: = Vector2(0,0)
var gravity: = 300.0

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	position += velocity*delta

func _on_Area2D_body_entered(_body):
	velocity = speed
	velocity.y += gravity*get_process_delta_time()
	
