extends CharacterBody2D

signal addLetter(text)

@onready var gun_sprite: AnimatedSprite2D = $Gun/GunSprite
@onready var character: Label = $Character

@export var speed: float = 100.0
@export var dodge_speed: float = 100.0
var specialChar = false

var player: Node2D
var movement_direction: Vector2
var dodge_side: int = 1


var char = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", 
			"S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

var special = ["A", "R", "J", "Y", "1", "2", "3"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gun_sprite.play(["1", "2", "3", "4"].pick_random())
	if !specialChar:
		character.text = char.pick_random()
	else:
		character.text = special.pick_random()
	
	player = get_tree().get_first_node_in_group("player")
	dodge_side = 1 if randi() % 2 == 0 else -1

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


func specialCharacter():
	specialChar = true
