extends AnimatedSprite2D
@onready var p_red: CharacterBody2D = $p_red

var player: String = ""
var is_active: bool = false


@onready var pickup_collider: CollisionShape2D = $doubleDamageArea/CollisionShape2D

signal red_double_damage
signal green_double_damage
signal reset_double_damage

func _ready() -> void:
	play("flame")

func _process(_delta: float) -> void:
	
	if not is_active:
		return
		
	if player == "p_red":
		position = $"../p_red".position + Vector2(2, 18)
	elif player == "p_green":
		position = $"../p_green".position + Vector2(0, 18)

func _on_double_damage_area_body_entered(body: Node2D) -> void:
	# Ignore collisions if someone already has the power-up
	if is_active:
		return
		
	if body.name == "p_red" or body.name == "p_green":
		is_active = true
		player = body.name
		play("aura")
		
		
		pickup_collider.set_deferred("disabled", true)
		
		
		if player == "p_red":
			red_double_damage.emit()
		else:
			green_double_damage.emit()


func _on_player_died() -> void:
	is_active = false
	player = ""
	position = Vector2.ZERO
	play("flame")
	
	pickup_collider.set_deferred("disabled", false)
	reset_double_damage.emit()
