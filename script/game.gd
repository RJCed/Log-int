extends Node2D

@onready var login_player: CharacterBody2D = $LoginPlayer
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var user_text: Label = $Username/UserText
@onready var pass_text: Label = $Password/PassText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_spawner.changeLetter.connect(changeLetter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	login_player.changeState()
	enemy_spawner.changeState()


var isUser = false
var isPass := false
var username = ""
var password = ""
func changeLetter(text):
	if isUser == false:
		user_text.text = ""
	
	
	isUser = true
	
	# Username
	if text == "Enter":
		isPass = true
		isUser = false
		
		if password.length() == 0:
			pass_text.text = ""
	elif !isPass and text == "Del" and isUser:
		username = username.substr(0, username.length() - 1)
		user_text.text = username
	elif !isPass and isUser:
		username += text
		user_text.text = username
	
	# Password
	if isPass and !(text == "Enter" or text == "Del"):
		
		password += text
		pass_text.text += "*"
		print(password)
	elif isPass and text == "Del":
		password = password.substr(0, password.length() - 1)
		pass_text.text = pass_text.text.substr(0, pass_text.text.length() - 1)
		print(password)
