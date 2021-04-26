extends KinematicBody2D

var velocity: = Vector2(0,0)
var gravity: = 450.0
var health: = 1.0
var speed : = Vector2(230,230)

#var d_charge = 0
#var p_charge = 0
var r_charge = 0 

signal death
#signal end

func _ready():
# warning-ignore:return_value_discarded
	connect("death", get_parent(),"death")
## warning-ignore:return_value_discarded
#	connect("end",self.get_parent().get_parent(),"end")
	if r_charge == 1: get_node("ColorRect").visible = false 

func _physics_process(_delta):
	var jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction = get_direction()
	
	if not is_on_floor():
		$AnimatedSprite.stop()
	else:
		$AnimatedSprite.flip_h = false
		if direction.x < 0: $AnimatedSprite.flip_h = true
		$AnimatedSprite.play()

	velocity = calculate_velocity(velocity,direction,speed,jump_interrupted)
	
	if Input.is_action_just_pressed("run") and r_charge > 0:
		var speed : = Vector2(600,600)
		$AnimatedSprite.play()
		r_charge -= 1
		$RunTimer.start()
	elif $RunTimer.is_stopped():
		velocity = calculate_velocity(velocity,direction,speed,jump_interrupted)
	velocity = move_and_slide(velocity,Vector2(0,-1))
#	if health <= 0:
#		emit_signal("death")

func calculate_velocity(linear_velocity: Vector2, direction: Vector2, _speed: Vector2, jump_interrupted: bool) -> Vector2:
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
		Input.get_action_strength("move_right")/2 - Input.get_action_strength("move_left")/2, 
	- 1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func _on_EnemyDetector_area_entered(area):
	if area.is_in_group("r"): r_charge += 1
	elif area.is_in_group("end"):
		get_node("ColorRect").visible = true 
		get_node("ColorRect").next_level(get_parent().level_n)
#	var impulse = 300
#	velocity.x = -impulse
#	velocity.y = -impulse
	area.queue_free()

func _on_EnemyDetector_body_entered(_body):
	if _body.is_in_group("enemy"):
		emit_signal("death")

#func take_damage(amount):
#	health -= amount
#	health = max(health,0.0)

#func _on_EnemyDetector_area_shape_entered(area_id, _area, _area_shape, _self_shape):
#	if area_id == 1399:
#		emit_signal("end")
