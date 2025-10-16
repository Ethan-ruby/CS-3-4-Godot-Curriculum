extends npc

class_name enemy

@onready var sprite: Sprite2D = $Sprite2D
@export var damage_amount: int = 25

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass

func _on_detection_radius_body_entered(body: Node2D) -> void:
	super._on_detection_radius_body_entered(body)
	if body is Player:
		is_hostile = true;
		$AnimatedSprite2D.play("Agro")

func _on_detection_radius_body_exited(body: Node2D) -> void:
	super._on_detection_radius_body_exited(body)
	if body is Player:
		is_hostile = false;
		$AnimatedSprite2D.play("Idle")

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player touched spike! Dealing " + str(damage_amount) + " damage")
		
		if body.has_method("change_health"):
			body.change_health(damage_amount)
