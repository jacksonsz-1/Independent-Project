extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var walk: CollisionShape2D = $LindaWalkCollision
@onready var idle: CollisionShape2D = $LindaIdleCollision
@onready var jump: CollisionShape2D = $LindaJumpCollision
@export var max_health: int = 100
var current_health: int
var lives: int = 3

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

signal health_change(new_health)


func _ready():
	current_health = max_health
	take_damage(30)
	print(current_health)

func take_damage(amount: int):
	current_health -= amount
	health_change.emit(current_health)
	
	if current_health <= 0:
		die()

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.flip_h = (direction < 0)
		animated_sprite.play("jump")
		jump.disabled = false
		walk.disabled = true
		idle.disabled = true
		
	if animated_sprite.frame == 3 and is_on_floor():
			animated_sprite.play("idle")
			jump.disabled = true
			walk.disabled = true
			idle.disabled = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
		
		if is_on_floor and not animated_sprite.animation == "jump" and not animated_sprite.animation == "punch":
			animated_sprite.play("walk")
			animated_sprite.flip_h = (direction < 0)
			walk.disabled = false
		
		
		
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not Input.is_anything_pressed() and is_on_floor() and not animated_sprite.animation == "punch":
			animated_sprite.play("idle")
			idle.disabled = false
			jump.disabled = true
			walk.disabled = true
		

	move_and_slide()
	
	
	## attacks
	if Input.is_action_just_pressed("linda punch"):
		animated_sprite.play("punch")
		
	if animated_sprite.animation == "punch" and animated_sprite.frame == 2:
		animated_sprite.play("idle")
		
		
func die():
	pass


func _on_charla_health_changed(new_health: Variant) -> void:
	pass # Replace with function body.
