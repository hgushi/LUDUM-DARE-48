extends KinematicBody2D
class_name Player


var velocity: = Vector2(0,0)
var gravity: = 300.0
var health: = 1.0
signal death

func _ready():
# warning-ignore:return_value_discarded
	connect("death",self.get_parent().get_parent(),"death")

func _physics_process(_delta):
	var speed : = Vector2(1000,1000)
	var jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction = get_direction()
	velocity = calculate_velocity(velocity,direction,speed,jump_interrupted)
	move_and_slide(velocity,Vector2(0,-1))
	if health <= 0:
		emit_signal("death")

func calculate_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2, jump_interrupted: bool) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = direction.x*speed.x
	new_velocity.y += gravity*get_physics_process_delta_time()
	if direction.y == -1:
		new_velocity.y = -speed.y
	if jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

func get_direction() -> Vector2:
	 return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
	- 1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func _on_EnemyDetector_area_entered(area):
	var impulse: = 0
	if area.layers == 5:
		impulse = 100
	else:
		impulse = 200
	velocity.y = -velocity.y*impulse

func _on_EnemyDetector_body_entered(_body):
	take_damage(1)

func take_damage(amount):
	health -= amount
	health = max(health,0.0)
