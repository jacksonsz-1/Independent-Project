extends Node2D
@onready var p_red: CharacterBody2D = $p_red
@onready var marker: Marker2D = $redMarker

@onready var p_green: CharacterBody2D = $p_green
@onready var marker2: Marker2D = $greenMarker

func _ready() -> void:
	for p_red in get_tree().get_nodes_in_group("p_red"):
		p_red.respawned.connect(_on_p_red_respawn.bind(p_red))
	for p_green in get_tree().get_nodes_in_group("p_green"):
		p_red.respawned.connect(_on_p_green_respawn.bind(p_green))
	

func _on_p_red_respawn():
	p_red.global_position = marker.global_position

func _on_p_green_respawn():
	p_green.global.position = marker2.global_position
	
	
