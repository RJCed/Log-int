extends Node2D


@onready var login_player: CharacterBody2D = $LoginPlayer
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var user_text: Label = $Username/UserText
@onready var pass_text: Label = $Password/PassText
@onready var login_label: Label = $Box/LoginLabel
@onready var bullet_detector: Area2D = $Obstacle/BulletDetector
@onready var auth_timer: Timer = $AuthTimer
@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic
@export var success_scene: PackedScene
@onready var error_sound: AudioStreamPlayer2D = $ErrorSound

const crosshair = preload("uid://bd2jcovt8cam3")
const cursor = preload("uid://4wsj3g7fiyu7")

var isUser = false
var isPass := false
var username = ""
var password = ""

var defaultUser = "ARJAY"
var defaultPass = "123"

var startGame = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor)
	
	enemy_spawner.changeLetter.connect(changeLetter)
	bullet_detector.loginHit.connect(login)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if startGame == false:
		login_player.changeState()
		enemy_spawner.changeState()
		
		Input.set_custom_mouse_cursor(crosshair)
		background_music.play()
		
		startGame = true
	


func _on_background_music_finished() -> void:
	background_music.play()
	
	


# Changing labels/add letters
func changeLetter(text):
	if isUser == false:
		user_text.text = ""
		password = ""
	
	isUser = true
	
	# Username
	if text == "Enter":
		isPass = true
		if password.length() == 0:
			pass_text.text = ""
	elif !isPass and text == "Del" and isUser:
		username = username.substr(0, username.length() - 1)
		user_text.text = username
		print("Username:" + username)
	elif !isPass and isUser:
		username += text
		user_text.text = username
		print("Username:" + username)
		
	
		
	# Password
	if isPass and text == "Del" and password.length() == 0: # Change the back to the user if Del is hit and empty
		isUser = true
		isPass = false
		pass_text.text = "Password"
	elif isPass and text == "Del" and password.length() != 0:
		password = password.substr(0, password.length() - 1)
		pass_text.text = pass_text.text.substr(0, pass_text.text.length() - 1)
		print("Password:" + password)
	elif isPass and text != "Enter":
		password += text
		pass_text.text += "*"
		print("Password:" + password)

func login():
	if username == defaultUser and password == defaultPass:
		print("OKAY LOGIN")
		get_tree().change_scene_to_packed(success_scene)
	else:
		error_sound.play()
		login_label.text = "Auth Error"
		auth_timer.start()


func _on_auth_timer_timeout() -> void:
	login_label.text = "LOG-IN'T"
