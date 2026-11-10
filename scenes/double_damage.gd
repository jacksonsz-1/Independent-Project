extends AnimatedSprite2D
@onready var p_red: CharacterBody2D = $p_red
var player = "hello"
var follow = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("flame")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if (follow = true):
			position.x = player.x

	


func _on_double_damage_area_body_entered(body: Node2D) -> void:
	if body.name == "p_red":
		print("p_red touching")
		play("aura")
		player = $p_red
		follow = true
		# Perform your logic here (e.g., body.take_damage())
