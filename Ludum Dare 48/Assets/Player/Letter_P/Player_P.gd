extends KinematicBody2D

var velocity: = Vector2(0,0)
var gravity: = 400.0
var health: = 1.0
var speed : = Vector2(210,210)
var dash_charge = true

var d_charge = 0
var e_charge = 0
var p_charge = 0
var r_charge = 0 

signal death
signal end

func _ready():
# warning-ignore:return_value_discarded
	connect("death",self.get_parent().get_parent(),"death")
	connect("end",self.get_parent().get_parent(),"end")
	

func _physics_process(_delta):
	var jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction = get_direction()
	
	if not is_on_floor():
		$AnimatedSprite.animation = "Idle_P"
		$AnimatedSprite.stop()
	elif direction.x == 0:
		$AnimatedSprite.animation = "Idle_P"
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.flip_h = false
		if direction.x < 0:
			$AnimatedSprite.flip_h = true
		$AnimatedSprite.animation = "Walk_P"
		$AnimatedSprite.play()
	if Input.is_action_pressed("Pause") and p_charge > 0:
		if get_tree().paused == false:
			p_charge -= 1
			$PauseTimer.start()
			get_tree().paused = true
		else:
			get_tree().paused = false
		
		
	velocity = calculate_velocity(velocity,direction,speed,jump_interrupted)
	velocity = move_and_slide(velocity,Vector2(0,-1))
#	if health <= 0:
#		emit_signal("death")

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
		Input.get_action_strength("move_right")/2 - Input.get_action_strength("move_left")/2, 
	- 1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func _on_EnemyDetector_area_entered(area):
	if area.is_in_group("d"): d_charge += 1
	elif area.is_in_group("e"): e_charge += 1
	elif area.is_in_group("p"): p_charge += 1
	elif area.is_in_group("r"): r_charge += 1
	var impulse = 300
	velocity.x = -impulse
	velocity.y = -impulse
	area.queue_free()

func _on_EnemyDetector_body_entered(_body):
	if _body.is_in_group("enemy"):
		emit_signal("death")

#func take_damage(amount):
#	health -= amount
#	health = max(health,0.0)


func _on_EnemyDetector_area_shape_entered(area_id, area, area_shape, self_shape):
	if area_id == 1399:
		emit_signal("end")

func _on_PauseTimer_timeout():
	get_tree().paused = false
