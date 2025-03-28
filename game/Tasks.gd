extends Node

func _ready():
	connect("_player_picked_up_task", _on_player_picked_up_task)

func _on_player_picked_up_task():
	print("Player picked up a task!")
