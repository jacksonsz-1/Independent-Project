extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass





func _on_charla_health_changed(new_health: Variant) -> void:
	value = new_health
