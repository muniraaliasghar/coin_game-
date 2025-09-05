extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity= ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta:float)-> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction= 1,-1,0 
	var direction := Input.get_axis("move left", "move right")
	
	#flips the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false 
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("idle")
			else:
					animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
