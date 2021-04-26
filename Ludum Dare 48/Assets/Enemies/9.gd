extends KinematicBody2D

var speed = 20
var velocity: = Vector2(0,0)
var slide_range = 6400
var distance_walked = 0
var gravity = 400.0

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if distance_walked < slide_range:
		if is_on_wall(): velocity.x *= -1.0
		velocity.y = move_and_slide(velocity,Vector2(0,-1)).y
		distance_walked += abs(velocity.x)
		
	else:
		velocity.x *= -1.0
		velocity.y = move_and_slide(velocity,Vector2(0,-1)).y
		distance_walked = 0

func _ready():
	set_physics_process(false)
	velocity.x = -speed


