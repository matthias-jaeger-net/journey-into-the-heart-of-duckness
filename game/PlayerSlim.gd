extends CharacterBody3D

var speed = 3.0
var running_speed = speed * 2.3
var jump_velocity = 4.5
var sensitivity = 0.02
var gravity = 14.0

@onready var duck = %set_duck
@onready var pivot = %SpringArm3D
@onready var animations = %AnimationPlayer
@onready var kaboom = %Kaboom

var flash_count = 10
var is_jumping = false
var is_running = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-15), deg_to_rad(35))

func _physics_process(delta):	
	if Input.is_action_just_pressed("run"):
		is_running = true
	
	if Input.is_action_just_released("run"):
		is_running = false
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
		if animations.current_animation != "Jump":
			animations.play("Jump")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		is_jumping = true

	if is_on_floor():
		if animations.current_animation == "Jump":
			is_jumping = false
			
	if is_on_floor():
		if Input.is_action_just_pressed("spell"):
			if animations.current_animation != "Spell":
				animations.play("Spell")
		
		if animations.current_animation == "Spell":
			kaboom.visible = true
		else: 
			kaboom.visible = false
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		var s = 0
		if is_running == true: 
			s = running_speed
		else:
			s = speed
			
		velocity.x = direction.x * s
		velocity.z = direction.z * s
		
		if is_jumping != true:
			if is_running == true: 
				if animations.current_animation != "Running":
					animations.play("Running")
			else:
				if animations.current_animation != "Walking":
					animations.play("Walking")
				
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

		if is_jumping != true:
				if animations.current_animation == "Spell":
					animations.play("Spell")
				else:
					animations.play("Calm")
					
	
	
	move_and_slide()
