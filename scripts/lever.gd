extends Area2D

var level_switched = false;

func play_animation(reverse: bool = false) -> void:
	var speed: int
	if reverse:
		speed = -1
	else:
		speed = 1
	$AnimatedSprite2D.play("", speed, reverse)


func _on_body_entered(body: Node2D) -> void:
	if body is Player and level_switched == false:
		$AnimatedSprite2D.play("opened")
		level_switched = true;
