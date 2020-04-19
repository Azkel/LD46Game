extends Node

var currentInventory = null
var requiredInventory = {}
var batteryLevel = 3000
var dialog_visible = false
var currentGood = ""
var stolen = false

var possibleItems = {
	"Beer" : [ "IPA", "Lager", "Pils"],
	"Fruits": [ "Apples", "Bananas", "Tomatoes"],
	"Spices": [ "Pepper", "Salt", "Oregano"],
	"Everyday Items": [ "Condoms", "Tissues", "Soap"],
	"Tea": [ "Green Tea", "Black Tea", "Tatratea"],
	"Dairy": [ "Milk", "Butter", "Yoghurt"],
	"Meat": [ "Chicken", "Beef", "Turkey"],
	"Cheese": [ "Gouda", "Gorgonzola", "Roquefort"],
	"Frozen Dish": [ "Pizza", "French Fries", "Shrimps"],
}

func _ready():
	currentInventory = {}
	requiredInventory = {}
	batteryLevel = 3000
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
