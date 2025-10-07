extends Area2D


@export var Lever: bool = false;

func play_animation(reverse: bool = false) -> void:
	var speed: int
	if reverse:
		speed = -1
	else:
		speed = 1
	$AnimatedSprite2D.play("", speed, reverse)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("opened")
		Lever = true;
