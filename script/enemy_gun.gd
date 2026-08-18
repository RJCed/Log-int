extends Node2D

@export var bullet_scene: PackedScene

@onready var gun_sprite: AnimatedSprite2D = $GunSprite
@onready var muzzle: Marker2D = $Muzzle

var player: Node2D


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _process(_delta):
	if player == null:
		return

	var player_position = player.global_position

	look_at(player_position)

	# Flip gun when player is to the left
	gun_sprite.flip_v = player_position.x < global_position.x


func shoot():
	if player == null:
		return

	var bullet = bullet_scene.instantiate()

	bullet.global_position = muzzle.global_position
	bullet.global_rotation = global_rotation
	bullet.team = "enemy"
	bullet.speed = 300.0  # default 800.0
	get_tree().current_scene.add_child(bullet)


func _on_shoot_timer_timeout() -> void:
	shoot()
