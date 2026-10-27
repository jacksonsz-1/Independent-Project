extends ProgressBar
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	if player:
		max_value = player.max_health
		value = player.current_health
		player.connect("health_changed", _on_player_health_changed)


func _on_player_health_changed(new_health: float) -> void:
	value = new_health
