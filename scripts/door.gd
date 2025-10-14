extends AnimatableBody2D
@onready var lever: Area2D = $"../Lever"
@onready var door = $"../Lever"

var is_open = true

func _process(delta):
	leverDetect()
	set_is_open()


func set_is_open() -> void:
	if is_open:
		$AnimatedSprite2D.frame = 0
		collision_layer = 1
		$LightOccluder2D.visible = false
	else:
		$AnimatedSprite2D.frame = 1
		collision_layer = 0
		$LightOccluder2D.visible = true


func leverDetect():
	if lever != null:
		if lever.level_switched == true:
			is_open = false
