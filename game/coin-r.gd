extends Node3D

@onready var animation = %AnimationPlayerCoin

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Node ready!") 
	if animation != null:
		animation.play("CircleAction")
	else:
		print("AnimationPlayerCoin node not found or not of the correct type.")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
