extends Node2D

const cursor = preload("uid://4wsj3g7fiyu7")
@onready var sound_win: AudioStreamPlayer2D = $SoundWin

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sound_win.play()
	Input.set_custom_mouse_cursor(cursor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
