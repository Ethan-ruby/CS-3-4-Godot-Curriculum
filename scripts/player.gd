extends CharacterBody2D
class_name Player

@onready var label: Label = $Coin/Label
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed: float = 200.0
@export var maxHealth : int = 4
@export var health : int = maxHealth
@export var coins : int = 0

var facing: Vector2 = Vector2.ZERO

func _ready():
	print("Player is ready!")
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(delta):
	handle_movement()

func handle_movement():
	# Get input direction from arrow keys
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	handle_sprite(direction)
	
	# Normalize diagonal movement to prevent speed boost
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement using Godot's built-in physics
	velocity = direction * move_speed
	move_and_slide()

func handle_sprite(direction: Vector2) -> void:
	var prefix: String = "walk"
	if direction == Vector2.ZERO:
		prefix = "idle"
	else:
		facing = direction
	
	if facing.y > 0:
		$Playerframes.play(prefix + "_forward")
	elif facing.y < 0:
		$Playerframes.play(prefix + "_backward")
	elif facing.x < 0:
		$Playerframes.play(prefix + "_side")
		$Playerframes.flip_h = true
	elif facing.x > 0:
		$Playerframes.play(prefix + "_side")
		$Playerframes.flip_h = false

func collect_pickup(_type : String, _amount : int):
	if _type == "coin":
		coins += _amount
		print("Coins: " + str(coins))
	elif _type == "health_potion":
		change_health(_amount)

func change_health(_amount): 
	health += _amount
	if health > maxHealth:
		health = maxHealth
		
	elif health < 1:
		die()
		
	print("Health: " + str(health))

func die():
	print("You died!")
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit game"):
		get_tree().quit()
	if Input.is_action_just_pressed("retart game"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	$Coin/Label.text = str(coins)
	
	if health == 4:
		$HealthBar.play("4")
	if health == 3:
		$HealthBar.play("3")
	if health == 2:
		$HealthBar.play("2")
	if health == 1:
		$HealthBar.play("1")
