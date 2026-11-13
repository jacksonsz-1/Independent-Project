extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var walk: CollisionShape2D = $CharlaWalkCollision
@onready var idle: CollisionShape2D = $CharlaIdleCollision
@onready var jump: CollisionShape2D = $CharlaJumpCollision
@onready var punch: Area2D = $CharlaPunchCollision
@onready var punchBox = $PunchHitbox/CharlaPunchCollision
@export var max_health: int = 100
var current_health: int
var lives: int = 3
signal respawn_r()
signal newgame()
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var doubleDamage = 1




#SIGNALS
signal health_changed(new_health)
signal green_health_dealt(amount)
signal red_punching()
signal double_damage()





func _ready():
	current_health = max_health
	punchBox.disabled = true


func take_damage(amount: int):
	current_health -= amount
	
	health_changed.emit(current_health)
	
	if current_health <= 0:
		die()
	


func _physics_process(delta: float) -> void:
	
	if global_position.y > 500:
		die()
	if lives <= 0:
		lose()
	
	var direction := Input.get_axis("Left", "Right")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
		jump.disabled = false
		idle.disabled = true
		walk.disabled = true
		$PunchHitbox/CharlaPunchCollision.disabled = true
		
	if animated_sprite.frame == 3 and is_on_floor():
			animated_sprite.play("idle")
			idle.disabled = false
			walk.disabled = true
			jump.disabled = true
			$PunchHitbox/CharlaPunchCollision.disabled = true
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
		
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
			$PunchHitbox/CharlaPunchCollision.scale.x = 1
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
			$PunchHitbox/CharlaPunchCollision.scale.x = -1
			
		
		
		if is_on_floor and not animated_sprite.animation == "jump" and not animated_sprite.animation == "punch":
			animated_sprite.play("walk")
			walk.disabled = false
			jump.disabled = true
			idle.disabled = true
			$PunchHitbox/CharlaPunchCollision.disabled = true
		
		
		
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not Input.is_anything_pressed() and is_on_floor() and not animated_sprite.animation == "punch":
			animated_sprite.play("idle")
			idle.disabled = false
			jump.disabled = true
			walk.disabled = true
			$PunchHitbox/CharlaPunchCollision.disabled = true
		

	move_and_slide()
	
	
	## attacks
	if Input.is_action_just_pressed("charla punch"):
		punches()
		
	if animated_sprite.animation == "punch" and animated_sprite.frame == 2:
		animated_sprite.play("idle")
		
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		#if Input.is_action_just_pressed("charla punch") and collider.name == "p_green":
			#green_health_dealt.emit(3)	
	
	
#recieving damage
func _on_p_green_red_health_dealt(amount: Variant) -> void:
	take_damage(3)
	
func punches():
	# Turn on hitbox
	animated_sprite.play("punch")
	idle.disabled = false
	jump.disabled = true
	walk.disabled = true
	$PunchHitbox/CharlaPunchCollision.disabled = false
	
	await get_tree().physics_frame

	# Get all overlapping CHARACTER BODIES
	var targets = $PunchHitbox.get_overlapping_bodies()
	
	for target in targets:
		# Make sure you don't punch yourself, and the enemy can take damage
		if target != self and target.has_method("take_damage"):
			target.take_damage(2 * doubleDamage)
			
	# Turn hitbox back off
	
func die():
	current_health = 100
	lives -= 1
	health_changed.emit(current_health)
	print(lives)
	respawn_r.emit()

func lose():
	current_health = 100
	lives = 3
	health_changed.emit(current_health)
	newgame.emit()
	print("green player wins uwu~~~~~~")
	get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
	


func _on_double_damage_red_double_damage() -> void:
	doubleDamage = 2
