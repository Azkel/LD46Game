extends Node2D


func _ready():
	var allRequiredItems = []
	var allStoredItems = []
	var score = 0
	var endText = ""
	var minusScore = 0
	var maxPoints = 0
	var items = ""
	var forgotten = ""
	if(Inventory.stolen):
		endText = "You didn't pay for your shopping! You were arrested on the way home!\nYou got -999 points. Don't pick up a soap under the shower in jail!"
		$RichTextLabel.text = endText
		return
	for x in Inventory.requiredInventory.keys():
		allRequiredItems.append(Inventory.requiredInventory[x])
	maxPoints = allRequiredItems.size() * 10
	for x in Inventory.currentInventory.keys():
		allStoredItems += Inventory.currentInventory[x]
	for x in allStoredItems:
		if x in allRequiredItems:
			var id = allRequiredItems.find(x)
			allRequiredItems.remove(id)
			score += 10
		else:
			minusScore += 5
			items += x + ", "
	for x in allRequiredItems:
		forgotten += x + ", "
	forgotten = forgotten.substr(0,forgotten.length() -2)
	items = items.substr(0,items.length() -2)
	endText = "You were able to get " + str(score) + " points for buying what's on the list!\n"
	if(allRequiredItems.size() > 0):
		$RichTextLabel4.text = "You forgotten to buy: " + forgotten
	if(minusScore > 0):
		endText += "Still, you have lost " + str(minusScore) + " points for buying things that were not on the list. \n"
		$RichTextLabel3.text = "You didn't had to buy: " + items
	endText += "Your final result: " + str(score-minusScore) + " out of " + str(maxPoints) + " points."
	$RichTextLabel.text = endText

	pass

func _input(event):
	if(event.is_action_pressed("ui_accept")):
		Inventory._ready()
		get_tree().change_scene("res://scenes/levels/FirstLevel.tscn")
