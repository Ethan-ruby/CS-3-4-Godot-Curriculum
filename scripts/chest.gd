extends Area2D


func animate_opening() -> void:
	$AnimatedSprite2D.play()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animate_opening()
