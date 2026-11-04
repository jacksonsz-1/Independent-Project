extends Node2D
@onready var p_red: CharacterBody2D = $p_red
@onready var marker: Marker2D = $p_red/Marker2D

func _ready() -> void:
	for p_red in get_tree().get_nodes_in_group("p_red"):
		p_red.respawned.connect(_on_p_red_respawn.bind(p_red))

func _on_p_red_respawn():
	p_red.global_position = marker.global_position
	
	
