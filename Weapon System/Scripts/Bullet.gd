extends KinematicBody2D

var direction := Vector2.RIGHT
export(float) var speed:float = 400
export(float) var damage:float = 10


func _ready():
	set_as_toplevel(true)
	direction = direction.normalized()
	look_at(direction + global_position)

func _physics_process(delta):
	var vel = direction * speed * delta
	var col = move_and_collide(vel, false)
	
	if(col and col.collider):
		if(col.collider.has_method("takeDamage")):
			col.collider.takeDamage(damage)
		
		if(col.collider.has_method("apply_impulse")):
			col.collider.apply_impulse(col.collider.global_position, direction)
		
		queue_free()
