extends Node2D

@onready var marker: Marker2D = $p_red/Marker2D

func _on_player_respawned(p_red):
	p_red.global_position = marker.global_position
