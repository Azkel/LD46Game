extends Node2D


func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/levels/FirstLevel.tscn")
