extends CharacterBody2D

@export var speed: float = 200.0
@onready var gun: Node2D = $Gun

var gameStart = false

func _physics_process(_delta):
	if gameStart:
		var direction = Vector2(
			Input.get_axis("left", "right"),
			Input.get_axis("up", "down")
		).normalized()

		velocity = direction * speed
		move_and_slide()

func changeState():
	gameStart = true
	gun.changeState()

func take_damage() -> void:
	get_tree().reload_current_scene()
