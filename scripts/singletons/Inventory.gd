extends Node

var currentInventory = null
var requiredInventory = {}
var batteryLevel = 500
var dialog_visible = false
var currentGood = ""

var possibleItems = {
	"Beer" : [ "IPA", "Lager", "Pils"],
	"Real Alcohol": [ "Whisky Bottle", "Gin Bottle", "Rum Bottle"],
	"Fruits": [ "Apples", "Bananas", "Tomatoes"],
	"Vegetables": [ "Carrots", "Potatoes", "Cabbage"],
	"Spices": [ "Pepper", "Salt", "Oregano"],
	"Everyday Items": [ "Condoms", "Tissues", "Soap"],
	"Tea": [ "Green Tea", "Black Tea", "Tatratea"],
	"Dairy": [ "Milk", "Butter", "Yoghurt"],
	"Meat": [ "Chicken", "Beef", "Turkey"],
	"Cheese": [ "Fresh", "Blue", "Hard"],
	"Frozen Dish": [ "Pizza", "French Fries", "Shrimps"],
}

func _ready():
	currentInventory = {}
	prepareInventory()
	pass


func prepareInventory() :
	var list = possibleItems.keys()
	var sample = []
	randomize()
	for i in range(5):
		var x = randi()%list.size()
		sample.append(list[x])
		list.remove(x)
	for x in sample:
		requiredInventory[x] = possibleItems[x][randi()%3]
	currentInventory[(requiredInventory.keys()[0])] = [requiredInventory[requiredInventory.keys()[0]]]
