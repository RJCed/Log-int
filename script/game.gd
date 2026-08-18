extends Node2D

@onready var login_player: CharacterBody2D = $LoginPlayer
@onready var enemy_spawner: Node2D = $EnemySpawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	login_player.changeState()
	enemy_spawner.changeState()
