@tool

extends pickup
class_name chest
var chestOpen = false;

func _ready() -> void:
	super._ready()
	body_entered.connect(_on_body_entered)
	configure_pickup(type,label)
func animate_opening() -> void:
	$AnimatedSprite2D.play()


func _on_body_entered(body: Node2D) -> void:
	super._on_body_entered(body)
	if body is Player && chestOpen == false:
		animate_opening()
		chestOpen = true
