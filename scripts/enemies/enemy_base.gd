extends npc

class_name enemy

@onready var sprite: Sprite2D = $Sprite2D
@export var damage_amount: int = 1

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass

func _on_detection_radius_body_entered(body: Node2D) -> void:
	super._on_detection_radius_body_entered(body)
	if body is Player:
		is_hostile = true;
		$AnimatedSprite2D.modulate = Color(0.859, 0.401, 0.391, 1.0)
func _on_detection_radius_body_exited(body: Node2D) -> void:
	super._on_detection_radius_body_exited(body)
	if body is Player:
		is_hostile = false;
		$AnimatedSprite2D.modulate = Color(1,1,1)

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("change_health"):
			body.change_health(damage_amount)
