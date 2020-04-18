extends Node2D
var counter = 0

func _ready():
	pass
	
func refreshInventory():
	var result = ""
	for x in Inventory.requiredInventory.keys():
		result += str(x) + " - " + str(Inventory.requiredInventory[x]) + "\n"
	$Sprite/WhatToBuy.text = result

func refreshToBuy():
	if(Inventory.batteryLevel <= 0):
		$Sprite2.visible = true
		$Sprite.visible = false
	else:
		refreshInventory()
		$Sprite/Battery.text = str(Inventory.batteryLevel/100) + "%"
		counter += 1
	
func _process(delta):
	if(self.visible):
		Inventory.batteryLevel -= 2
		refreshToBuy()
