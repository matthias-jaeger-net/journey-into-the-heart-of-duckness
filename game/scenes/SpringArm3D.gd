extends SpringArm3D

@onready var raycast = $RayCast3D

func _physics_process(delta):
	raycast.force_raycast_update()  # Check for collisions

	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		var new_length = global_transform.origin.distance_to(collision_point) - 0.2
		spring_length = max(new_length, 1.0)  # Keep a minimum distance
	else:
		spring_length = 2.0  # Default distance
