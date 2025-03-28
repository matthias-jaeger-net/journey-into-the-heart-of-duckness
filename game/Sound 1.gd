extends Node3D

@onready var audio_player = $"../Sound 2/AudioStreamPlayer3D"

var current_volume = -80  # Start at silence (-80 dB)
var target_volume = -80  # This will change to 0 or -80 depending on fade in/out
var fade_speed = 5  # How fast the volume fades (higher value = faster fade)

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player.play()
	audio_player.volume_db = current_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Smoothly adjust the volume towards the target volume
	if current_volume < target_volume:
		current_volume = min(current_volume + fade_speed * delta, target_volume)  # Fade in
	elif current_volume > target_volume:
		current_volume = max(current_volume - fade_speed * delta, target_volume)  # Fade out

	audio_player.volume_db = current_volume

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		target_volume = 0  # Set the target volume to 0 dB for fade-in

func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		target_volume = -80  # Set the target volume to -80 dB for fade-out
