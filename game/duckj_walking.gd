extends Node3D

@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("Armature|mixamocom|Layer0")
	print("the fuck!!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
