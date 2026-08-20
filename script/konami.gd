extends Node

signal konami_activated
@onready var konami_sound: AudioStreamPlayer2D = $KonamiSound

var isKonami = false

var sequence = [
	"up",
	"up",
	"down",
	"down",
	"left",
	"right",
	"left",
	"right",
	"konami_b",
	"left", # konami_a
	"konami_enter"
]

var current_index := 0


func _input(event):
	if isKonami == false:
		if not event.is_pressed():
			return

		var action = get_action_from_event(event)

		if action == "":
			return

		if action == sequence[current_index]:
			current_index += 1

			if current_index >= sequence.size():
				activate_konami_code()
		else:
			current_index = 0


func get_action_from_event(event) -> String:
	for action in sequence:
		if event.is_action_pressed(action):
			return action

	return ""


func activate_konami_code():
	if isKonami == false:
		konami_sound.play()
		print("Konami")
		konami_activated.emit()

		current_index = 0
		isKonami = true
