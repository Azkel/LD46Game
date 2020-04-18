extends Node2D

func refreshInventory():
	var result = ""
	for x in Inventory.currentInventory.keys():
		result += str(x) + " - "
		for y in Inventory.currentInventory[x]:
			result += y + ", "
		result = result.substr(0,result.length() -2)+ "\n"
	$Inventory.text = result

func _ready():
	pass
