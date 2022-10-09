extends Resource
class_name WeaponData

export(PackedScene) var Projectile:PackedScene
export(float) var TimeTweenShots:float = 0.2

func GetProjectilePath() -> String:
	return Projectile.resource_path
