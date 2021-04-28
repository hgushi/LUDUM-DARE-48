extends KinematicBody2D

var gravity: = 150.0
var start_position = position.y
var jump = false
onready var JumperCollision = $JumperCollision
onready var JumperCollision2 = $JumperCollision2
onready var Jumper = $Jumper
onready var Jumper2 = $Jumper2
func _on_AttackTimer_timeout():
	jump = true
	yield(get_tree().create_timer(1.0), "timeout")
	jump = false
	
#var speed : = Vector2(500,1000)
#var velocity: = Vector2(0,0)

#func _ready():
#	set_physics_process(false)
#	velocity.x = - speed.x
#
func _physics_process(delta):
	if jump and $JumperCollision.position.y > start_position - 32:
		$JumperCollision.position.y -= gravity * delta
		$Jumper.position.y -= gravity * delta
		$JumperCollision2.position.y -= gravity * 2 * delta
		$Jumper2.position.y -= gravity * 2 * delta
	if not jump and $Jumper.position.y < start_position - 16:
		$JumperCollision.position.y += gravity * delta
		$Jumper.position.y += gravity * delta
		$JumperCollision2.position.y += gravity * 2 * delta
		$Jumper2.position.y += gravity * 2 * delta


func _on_VisibilityNotifier2D_screen_entered():
	$AttackTimer.start()


func _on_VisibilityNotifier2D_screen_exited():
	$AttackTimer.stop()
