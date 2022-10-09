extends Node2D
class_name ShootingBehavior

onready var timer = $Timer
onready var audio = $Audio

export(Resource) var WeaponResource:Resource

signal shotFired

var canShoot:bool = true

func Shoot():
	if(!canShoot):
		return
	
	audio.play()
	
	#create instance of projectile
	var projectile = WeaponResource.Projectile.instance()
	
	#Set varibles on projectile
	projectile.direction = Vector2.RIGHT.rotated(global_rotation)
	projectile.global_position = global_position
	projectile.add_collision_exception_with(get_parent())
	
	#Add to scene
	add_child(projectile)
	
	canShoot = false
	emit_signal("shotFired")
	timer.start(WeaponResource.TimeTweenShots)

func _on_Timer_timeout():
	canShoot = true
