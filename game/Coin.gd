extends StaticBody3D

@onready var label = %Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
		


func _on_game_coin_collected():
	pass # Replace with function body.
