extends KinematicBody2D

var velocity: = Vector2(0,0)
var gravity: = 400.0
var health: = 1.0
var speed : = Vector2(300,230)
var dash_charge = true
onready var AnimatedSprite = $AnimatedSprite
var collision_info

#var d_charge = 0
var p_charge = 0
var r_charge = 0 

signal death
# warning-ignore:unused_signal
#signal end

func _ready():
# warning-ignore:return_value_discarded
	connect("death", get_parent(),"death")
# warning-ignore:return_value_discarded
#	connect("end", get_parent(),"end")
	
	if p_charge == 1: get_node("ColorRect").visible = false 

func _physics_process(_delta):	
	var jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction = get_direction()
	
	if not is_on_floor():
		AnimatedSprite.animation = "Idle"
		AnimatedSprite.stop()
	elif direction.x == 0:
		AnimatedSprite.animation = "Idle"
		AnimatedSprite.play()
		
	if Input.is_action_just_pressed("pause") and p_charge > 0:
		if get_tree().paused == false:
			p_charge -= 1
			get_tree().paused = true
			$PauseTimer.start()
	if not $PauseTimer.is_stopped():
		$TimerLabel.text = str(int($PauseTimer.time_left + 1))
	else: $TimerLabel.text = ""
			
	collision_info = move_and_collide(velocity, true, true, true)
	
	velocity = calculate_velocity(velocity,direction,speed,jump_interrupted)
	velocity = move_and_slide(velocity,Vector2(0,-1))
#	if health <= 0:
#		emit_signal("death")

	if r_charge == 1: 
		var new_player = load("res://Assets/Player/Letter_R/Player_R.tscn").instance()
		new_player.position = position
		new_player.r_charge = 1 
		new_player.scale = Vector2(2, 2) 
		get_parent().add_child(new_player)
		queue_free()

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
	if area.is_in_group("p"): p_charge += 1
	elif area.is_in_group("r"): r_charge += 1
	elif area.is_in_group("end"):
		get_node("ColorRect").visible = true 
		get_node("ColorRect").next_level(get_parent().level_n)
#		emit_signal("end")
	area.queue_free()

func _on_EnemyDetector_body_entered(_body):
	if _body.is_in_group("enemy"):
		emit_signal("death")
	if _body.is_in_group("5"):
		bounce()

#func take_damage(amount):
#	health -= amount
#	health = max(health,0.0)

func bounce():
	var impulse = 750
	velocity.x = -impulse
	velocity.y = -impulse

func _on_PauseTimer_timeout():
	get_tree().paused = false
	$PauseTimer.stop()
