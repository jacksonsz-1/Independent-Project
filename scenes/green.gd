extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var walk: CollisionShape2D = $LindaWalkCollision
@onready var idle: CollisionShape2D = $LindaIdleCollision
@onready var jump: CollisionShape2D = $LindaJumpCollision
@onready var punchBox = $punchBox/LindaPunchCollision
@export var max_health: int = 100
var current_health: int
var lives: int = 3
var punching = false
var doubleDamage = 1
const SPEED = 300.0
const JUMP_VELOCITY = -500.0

signal respawn_g()
signal health_change(new_health)
signal red_health_dealt(amount)
signal newgame()


func _ready():
	current_health = max_health
	print(current_health)

func take_damage(amount: int):
	current_health -= amount
	health_change.emit(current_health)
	
	if current_health <= 0:
		die()

func _physics_process(delta: float) -> void:
	
	if global_position.y > 1000:
		die()
		
	if lives <= 0:
		lose()
	
	var direction := Input.get_axis("ui_left", "ui_right")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if animated_sprite.animation == "punch":
		punching = true
	
	else:
		punching = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
		idle.disabled = true
		walk.disabled = true
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
		
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = true
			$PunchHitbox/LindaPunchCollision.scale.x = 1
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = false
			$PunchHitbox/LindaPunchCollision.scale.x = -1
		
		if is_on_floor and not animated_sprite.animation == "jump" and not animated_sprite.animation == "punch":
			animated_sprite.play("walk")
			idle.disabled = true
			jump.disabled = true
			walk.disabled = false
			idle.disabled = true
			jump.disabled = true
		
		
		
		
		
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
	$PunchHitbox/LindaPunchCollision.disabled = false
	
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
	health_change.emit(current_health)
	lives -= 1
	print(current_health)
	print(lives)
	respawn_g.emit()
	
func lose():
	current_health = 100
	lives = 3
	health_change.emit(current_health)
	print("red player wins uwu~~~~~~")
	newgame.emit()
	get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
	


func _on_p_red_newgame() -> void:
	lives = 3
	current_health = 100
	health_change.emit(current_health)


func _on_double_damage_green_double_damage() -> void:
	doubleDamage = 2
