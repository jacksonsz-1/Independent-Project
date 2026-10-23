extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.flip_h = (direction < 0)
		animated_sprite.play("jump")
		
	if animated_sprite.frame == 3 and is_on_floor():
			animated_sprite.play("idle")
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
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
