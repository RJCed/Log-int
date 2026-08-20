extends Node2D

@export var bullet_scene: PackedScene

@onready var gun_sprite: Sprite2D = $GunSprite
@onready var muzzle: Marker2D = $Muzzle
@onready var sound_player: AudioStreamPlayer2D = $"../SoundPlayerGun"
@onready var sound_player_shoot: AudioStreamPlayer2D = $"../SoundPlayerShoot"

var gameStart = false

func _process(_delta):
	if gameStart:
		visible = true

	var mouse_position = get_global_mouse_position()

	look_at(mouse_position)

	# Flip gun when cursor is to the left
	gun_sprite.flip_v = mouse_position.x < global_position.x
	
	if Input.is_action_just_pressed("shoot"):
		shoot()


func changeState():
	if !gameStart:
		sound_player.play()
	gameStart = true
	


func shoot():
	if gameStart:
		sound_player_shoot.play()
		var bullet = bullet_scene.instantiate()

		bullet.global_position = muzzle.global_position
		bullet.global_rotation = global_rotation
		bullet.team = "player"

		get_tree().current_scene.add_child(bullet)
