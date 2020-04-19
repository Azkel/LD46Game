extends Node2D

export var type = "Beer"
export var buyText = "Co tam kupujemy kierowniku?"
var stolen = false
func _ready():
	stolen = get_parent().steal
	pass

func interact(object):
	Inventory.stolen = stolen
	get_tree().change_scene("res://scenes/levels/EndLevel.tscn")
	

func _on_Button_pressed():
	pass # Replace with function body.


func _on_Button_button_down():
	pass
