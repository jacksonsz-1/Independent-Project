extends AnimatedSprite2D
@onready var p_red: CharacterBody2D = $p_red
var player = "hello"
var follow = false
var greens = true
var reds = true

signal green_double_damage
signal red_double_damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("flame")
	print(position.x)
	print(position.y)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if player == "p_red" and reds == true:
			greens = false
			position.x = $"../p_red".position.x + 2
			position.y = $"../p_red".position.y + 18
			red_double_damage.emit()
			
		if player == "p_green" and greens == true:
			reds = false
			position.x = $"../p_green".position.x 
			position.y = $"../p_green".position.y + 18
			green_double_damage.emit()
			

	


func _on_double_damage_area_body_entered(body: Node2D) -> void:
	if body.name == "p_red":
		play("aura")
		player = body.name
		follow = true

	if body.name == "p_green":
		play("aura")
		player = body.name
		follow = true


func _on_node_2d_red_lose_double() -> void:
	reds = false
	greens = false
	position.x = 0
	position.y = 0
	reds = true
	greens = true
	
	play("flame")
