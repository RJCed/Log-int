extends Area2D

@export var speed: float = 800.0
var team: String = "player"

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(team):
		return # same team as shooter, pass through, no despawn

	var target_group = "enemy" if team == "player" else "player"

	if body.is_in_group(target_group):
		if body.has_method("take_damage"):
			body.take_damage()

	queue_free()
