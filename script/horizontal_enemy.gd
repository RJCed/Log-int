extends CharacterBody2D

signal addLetter(text)

@export var speed: float = 100.0
@export var dodge_speed: float = 100.0
var dodge_side: int = 1

var movement_direction: Vector2


@onready var character: Label = $Character

var type = randf()

func _ready() -> void:
	if type > 0.4:
		character.text = "Del"
	else:
		character.text = "Enter"


func _physics_process(_delta):
	velocity = movement_direction * speed

	if get_slide_collision_count() > 0:
		var dodge_direction = movement_direction.rotated(PI / 2) * dodge_side
		velocity += dodge_direction * dodge_speed
	
	move_and_slide()
	if is_outside_screen():
		queue_free()


func set_movement_direction(direction: Vector2):
	movement_direction = direction.normalized()


func is_outside_screen() -> bool:
	var camera = get_viewport().get_camera_2d()

	if camera == null:
		return false

	var viewport_size = get_viewport().get_visible_rect().size
	var center = camera.get_screen_center_position()
	var half_size = viewport_size / 2.0
	var margin = 150.0

	var bounds = Rect2(
		center - half_size - Vector2(margin, margin),
		viewport_size + Vector2(margin * 2, margin * 2)
	)

	return not bounds.has_point(global_position)


func take_damage() -> void:
	addLetter.emit(character.text)
	queue_free()
