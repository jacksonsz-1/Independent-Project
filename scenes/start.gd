extends Node2D
@onready var p_red: CharacterBody2D = $p_red
@onready var marker: Marker2D = $p_red/Marker2D

func _on_p_red_respawn() -> void:
	p_red.global_position = marker.global_position
	
	
