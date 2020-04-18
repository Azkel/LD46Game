extends Node2D


func _ready():
	var allRequiredItems = []
	var allStoredItems = []
	var score = 0
	var maxPoints = 0
	for x in Inventory.requiredInventory.keys():
		allRequiredItems.append(Inventory.requiredInventory[x])
	maxPoints = allRequiredItems.size() * 10
	for x in Inventory.currentInventory.keys():
		allStoredItems += Inventory.currentInventory[x]
	for x in allStoredItems:
		if x in allRequiredItems:
			allRequiredItems.remove(x)
			score += 10
		else:
			score -= 5
	
	$RichTextLabel.text = "No synek, udalo Ci sie zebrac " + str(score) + "z " + str(maxPoints) + "punktow!"
	pass
