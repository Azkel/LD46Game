extends Node2D

export var type =  ""
export var buyText = ""
func _ready():
	type = get_parent().type
	buyText = get_parent().buyText
	pass

func interact(object):
	Inventory.currentGood = type
	object.displayDialog(buyText)
	

func _on_Button_pressed():
	pass # Replace with function body.


func _on_Button_button_down():
	pass
