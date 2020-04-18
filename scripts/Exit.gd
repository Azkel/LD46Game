extends Node2D

export var type = "Beer"
export var buyText = "Co tam kupujemy kierowniku?"
func _ready():
	pass

func interact(object):
	get_tree().change_scene("res://scenes/levels/EndLevel.tscn")
	

func _on_Button_pressed():
	pass # Replace with function body.


func _on_Button_button_down():
	pass
