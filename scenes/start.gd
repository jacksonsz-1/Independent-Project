extends Node2D
@onready var p_red: CharacterBody2D = $p_red
@onready var marker: Marker2D = $redMarker

@onready var p_green: CharacterBody2D = $p_green
@onready var marker2: Marker2D = $greenMarker

signal green_lose_double
signal red_lose_double

func _ready() -> void:
	for p_red in get_tree().get_nodes_in_group("p_red"):
		p_red.respawned.connect(_on_p_red_respawn_r.bind(p_red))
	for p_green in get_tree().get_nodes_in_group("p_green"):
		p_red.respawned.connect(_on_p_green_respawn_g.bind(p_green))
	

func _on_p_red_respawn_r():
	p_red.global_position = marker.global_position
	p_red.current_health = 100
	red_lose_double.emit()

func _on_p_green_respawn_g():
	p_green.global_position = marker2.global_position
	p_green.current_health = 100
	
	
