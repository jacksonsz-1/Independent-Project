extends ProgressBar

@export var player: Node2D # Assign your player node in the Inspector

func _ready() -> void:
	if player:
		max_value = player.max_health
		value = player.current_health
		# If your player emits a signal when taking damage:
		player.health_changed.connect(_on_player_health_changed)

func _on_player_health_changed(new_health: float) -> void:
	value = new_health
