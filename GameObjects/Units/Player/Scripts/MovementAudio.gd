extends Node2D

onready var audio:AudioStreamPlayer2D = $Audio
onready var timer:Timer = $Timer
onready var ControlNode:PhysicsBody2D = get_node(controlNode)

export(NodePath) var controlNode:NodePath

export(float) var timeTweenSteps:float = 0.2

func _process(delta):
	#Footstep Audio
	if(ControlNode.Velocity != Vector2.ZERO):
		if(timer.time_left <= 0):
			audio.pitch_scale = rand_range(1, 1.1)
			audio.play()
			timer.start(timeTweenSteps)
