extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal health_changed(new_health: float)

@export var max_health: float = 100.0
var current_health: float = max_health

func take_damage(amount: float) -> void:
	current_health -= amount
	current_health = clamp(current_health, 0.0, max_health)
	
	health_changed.emit(current_health)
	
	if current_health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
		take_damage(20)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		
		if is_on_floor and not animated_sprite.animation == "jump":
			animated_sprite.play("walk")
			animated_sprite.flip_h = (direction < 0)
		
		
		
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not Input.is_anything_pressed() and is_on_floor():
			animated_sprite.play("idle")
		
		

	move_and_slide()
