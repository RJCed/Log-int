extends Node2D

var gameStart = false

@export var enemy_scene: PackedScene
@export var horizontal_enemy_scene: PackedScene
@export var spawn_distance: float = 100.0

@export var horizontal_enemy_offset: float = 30.0

#@onready var player = get_parent().get_node("Player")
@onready var enemies = get_parent().get_node("Enemies")


func _ready():
	$SpawnTimer.timeout.connect(spawn_enemy)


func spawn_enemy():
	if gameStart:
		print("Enemy")

		var spawn_type = randf()

		if spawn_type > 0.2:
			spawn_normal_enemy()
		else:
			spawn_horizontal_enemy()


func spawn_normal_enemy():
	var enemy = enemy_scene.instantiate()

	var viewport_size = get_viewport().get_visible_rect().size
	var camera = get_viewport().get_camera_2d()
	var screen_center = camera.get_screen_center_position()
	var half_size = viewport_size / 2.0

	var side = randi_range(0, 3)

	var spawn_position: Vector2
	var direction: Vector2

	match side:
		0: # Top
			spawn_position = Vector2(
				randf_range(
					screen_center.x - half_size.x,
					screen_center.x + half_size.x
				),
				screen_center.y - half_size.y - spawn_distance 
			)
			direction = Vector2.DOWN

		1: # Bottom
			spawn_position = Vector2(
				randf_range(
					screen_center.x - half_size.x,
					screen_center.x + half_size.x
				),
				screen_center.y + half_size.y + spawn_distance
			)
			direction = Vector2.UP

		2: # Left
			spawn_position = Vector2(
				screen_center.x - half_size.x - spawn_distance,
				randf_range(
					screen_center.y - half_size.y,
					screen_center.y + half_size.y
				)
			)
			direction = Vector2.RIGHT

		3: # Right
			spawn_position = Vector2(
				screen_center.x + half_size.x + spawn_distance,
				randf_range(
					screen_center.y - half_size.y,
					screen_center.y + half_size.y
				)
			)
			direction = Vector2.LEFT

	enemy.global_position = spawn_position
	enemy.set_movement_direction(direction)
	enemies.add_child(enemy)


func spawn_horizontal_enemy():
	var enemy = horizontal_enemy_scene.instantiate()
	var viewport_size = get_viewport().get_visible_rect().size
	var camera = get_viewport().get_camera_2d()
	var screen_center = camera.get_screen_center_position()
	var half_size = viewport_size / 2.0
	var spawn_position: Vector2
	var direction: Vector2
	# Randomly choose LEFT or RIGHT
	if randi_range(0, 1) == 0:
		# LEFT
		spawn_position = Vector2(
			screen_center.x - half_size.x - spawn_distance,
			randf_range(
				screen_center.y - half_size.y,
				screen_center.y + half_size.y
			)
		)
		direction = Vector2.RIGHT
	else:
		# RIGHT
		spawn_position = Vector2(
			screen_center.x + half_size.x + spawn_distance,
			randf_range(
				screen_center.y - half_size.y,
				screen_center.y + half_size.y
			)
		)
		direction = Vector2.LEFT
	enemy.global_position = spawn_position
	enemy.set_movement_direction(direction)
	enemies.add_child(enemy)


func changeState():
	gameStart = true
