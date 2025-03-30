# class Cookie
extends Node3D

# Parent node that holds possible spawn points 
@onready var spawn_points = %SpanPoints 

# Node that holds the bling bling sound
@onready var bling = %AudioStreamPlayer3D

func _ready():
	relocate_cookie()

# When something collides with the cookie
func _on_area_3d_body_entered(body):
	# And is actually the player 
	if body.is_in_group("player"):
		# We try to move the cookie in a new point
		relocate_cookie()
		# We play a nice bling bling sound
		bling.play()
		

# When we need a new point
func relocate_cookie():
	# We create a list of possible points
	var points = []
	
	# We look what is in the possible points
	for child in spawn_points.get_children():
		
		# When we have some points and it is not the point we are on
		if child is Node3D and child.global_transform.origin != global_transform.origin:
			# We add the point to the list of points
			points.append(child.global_transform.origin)

	# We check if there are actually points available
	if points.size() > 0:
		# We set the position of the cookie to a random point from the list
		global_transform.origin = points[randi() % points.size()]
