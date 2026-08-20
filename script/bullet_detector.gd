extends Area2D

signal loginHit

func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if area.team == "player":
		loginHit.emit()
