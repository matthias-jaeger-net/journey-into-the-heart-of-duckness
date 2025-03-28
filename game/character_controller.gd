extends CharacterBody3D

# Motion constants
const sensitivity = 0.02
const walking_speed = 4.0
const running_speed = 12.0
const jump_velocity = 6.5
const gravity = 14.0

# Character controller
@onready var pivot = %SpringArm3D
@onready var animation_player = %AnimationPlayer
@onready var character = %Character

# Flags
var is_jumping = false
var is_running = false

var look_at_angle = 0
var direction

func _input(event):
	if event is InputEventMouseMotion:
		look_at_angle = deg_to_rad(-event.relative.x * sensitivity)
		rotate_y(look_at_angle)
		pivot.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-15), deg_to_rad(35))

func _physics_process(delta):	
	
	velocity.y -= gravity * delta
	
	if not is_on_floor():
		if animation_player.current_animation != "Jump":
			animation_player.play("Jump")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		is_jumping = true

	if is_on_floor():
		if animation_player.current_animation == "Jump":
			is_jumping = false
			
	if Input.is_action_just_pressed("spell") and is_on_floor():
		if animation_player.current_animation != "Spell":
			animation_player.play("Spell")
	
	if Input.is_action_just_pressed("run"):
		is_running = true
		
	if Input.is_action_just_released("run"):
		is_running = false
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		# Horizontal rotation of character based on user input 
		if input_dir.x < 0:
			character.rotation.y = deg_to_rad(-120)
		elif input_dir.x > 0:
			character.rotation.y = deg_to_rad(120)
		elif input_dir.x == 0:
			character.rotation.y = deg_to_rad(180)

		# Find out what speed we need
		var actual_speed = running_speed if is_running else walking_speed
		velocity.x = direction.x * actual_speed
		velocity.z = direction.z * actual_speed
		
		if !is_jumping:
			if is_running == true: 
				if animation_player.current_animation != "Running":
					animation_player.play("Running")
			else:
				if animation_player.current_animation != "Walking":
					animation_player.play("Walking")
	else:
		character.rotation.y = deg_to_rad(180)  

		velocity.x = move_toward(velocity.x, 0, walking_speed)
		velocity.z = move_toward(velocity.z, 0, walking_speed)

		if is_jumping != true:
			if animation_player.current_animation == "Spell":
				animation_player.play("Spell")
			else:
				animation_player.play("Calm")

	move_and_slide()
