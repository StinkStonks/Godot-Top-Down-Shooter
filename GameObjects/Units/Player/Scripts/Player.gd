extends KinematicBody2D
class_name Player

onready var shootingBehavior := $ShootingBehavior

export(float) var speed:float = 300
export(float, 0, 1000) var health:float = 100

var isDead:bool = false
var inputVelocity:Vector2 = Vector2.ZERO
var Velocity:Vector2 = Vector2.ZERO

signal tookDamage(amount)
signal hasDied

func _ready():
	GameManager.player = self
	connect("hasDied", GameManager, "GameOver")

func _input(event):
	var xInput := float(Input.get_action_strength("Movement_Right") - Input.get_action_strength("Movement_Left"))
	var yInput := float(Input.get_action_strength("Movement_Down") - Input.get_action_strength("Movement_Up"))
	
	inputVelocity = Vector2(xInput, yInput).normalized()
	
	if(event.is_action_pressed("Action_Shoot") && shootingBehavior):
		shootingBehavior.Shoot()

func _physics_process(delta):
	Velocity = inputVelocity * speed * delta
	
	move_and_collide(Velocity, false)
	look_at(get_global_mouse_position())

func enable(b:bool):
	set_process(b)
	set_process_input(b)
	set_physics_process(b)

func takeDamage(amount:float):
	health -= amount
	
	if health <= 0:
		kill()
	
	emit_signal("tookDamage", amount)

func kill():
	if !isDead:
		health = 0
		enable(false)
		emit_signal("hasDied")
