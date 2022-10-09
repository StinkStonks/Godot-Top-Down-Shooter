extends KinematicBody2D

const MOVE_SPEED = 200

onready var raycast = $RayCast2D

export(float, 0, 1000) var health = 100

func _physics_process(delta):
	if GameManager.player == null:
		return
	
	var vec_to_player = GameManager.player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.takeDamage(1)

func takeDamage(amount:float):
	print(health)
	health -= amount
	if(health <= 0):
		kill()

func kill():
	queue_free()

