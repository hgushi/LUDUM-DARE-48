extends KinematicBody2D

var speed : = Vector2(1000,1000)
var velocity: = Vector2(0,0)
var gravity: = 300.0
var jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0
func _physics_processs(delta):
	var direction = get_direction()
	velocity.y += gravity*delta
	velocity.y = max(velocity.y,speed.y)
	if direction.y == -1:
		velocity.y = speed.y*direction.y
	if jump_interrupted == true:
		velocity.y = 0.0
	velocity = move_and_slide(velocity,Vector2(0,-1))

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_right"), 
	- 1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
