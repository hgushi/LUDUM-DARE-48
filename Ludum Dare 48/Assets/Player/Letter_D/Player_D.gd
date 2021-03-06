extends KinematicBody2D

var velocity: = Vector2(0,0)
var gravity: = 450.0
var health: = 1.0
var speed_abs : = Vector2(300,230)
onready var AnimatedSprite = $AnimatedSprite
var d_charge = 0
var p_charge = 0
#var r_charge = 0 

signal death
#signal end

func _ready():
# warning-ignore:return_value_discarded
	connect("death", get_parent(), "death")
#	connect("end",self.get_parent(),"end")
	

func _physics_process(_delta):
	var jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction = get_direction()
	
	if not is_on_floor():
		AnimatedSprite.animation = "Idle"
		AnimatedSprite.stop()
	elif direction.x == 0:
		AnimatedSprite.animation = "Idle"
		AnimatedSprite.play()
	else:
		AnimatedSprite.flip_h = false
		if direction.x < 0:
			AnimatedSprite.flip_h = true
		AnimatedSprite.animation = "Walk"
		AnimatedSprite.play()

	#velocity = move_and_slide(velocity,Vector2(0,-1))
#	velocity = calculate_velocity(velocity,direction,speed_abs,jump_interrupted)
	if Input.is_action_just_pressed("dash") and d_charge > 0:
		if AnimatedSprite.flip_h == true: velocity.x = -1000
		else: velocity.x = +850
		AnimatedSprite.animation = "Dash"
		AnimatedSprite.play()
		d_charge -= 1
		$DashTimer.start()
	elif $DashTimer.is_stopped():
		velocity = calculate_velocity(velocity,direction,speed_abs,jump_interrupted)
	
	velocity = move_and_slide(velocity,Vector2(0,-1))
#	var collision = move_and_collide(velocity, true, true, true)
#	if collision and collision.collider.is_in_group("5"):
#		velocity = velocity.bounce(collision.normal)
#	if health <= 0:
#		emit_signal("death")

	if p_charge == 1: 
		var new_player = load("res://Assets/Player/Letter_P/Player_P.tscn").instance()
		new_player.position = position
		new_player.p_charge = 1 
		new_player.scale = Vector2(2, 2) 
		get_parent().add_child(new_player)
		queue_free()

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
	elif area.is_in_group("p"): p_charge += 1
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

#func _on_EnemyDetector_area_shape_entered(area_id, area, area_shape, self_shape):
##	if area_id == 1399: emit_signal("end")
#	if area.is_in_group("end"): emit_signal("end")
