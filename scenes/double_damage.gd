extends AnimatedSprite2D
@onready var p_red: CharacterBody2D = $p_red
var player = "hello"
var follow = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("flame")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if player == "p_red":
			position.x = $"../p_red".position.x + 2
			position.y = $"../p_red".position.y + 18
			
		if player == "p_green":
			position.x = $"../p_green".position.x 
			position.y = $"../p_green".position.y + 18
			

	


func _on_double_damage_area_body_entered(body: Node2D) -> void:
	if body.name == "p_red":
		play("aura")
		player = body.name
		follow = true

	if body.name == "p_green":
		play("aura")
		player = body.name
		follow = true
