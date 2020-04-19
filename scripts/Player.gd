extends Area2D
onready var ray = $RayCast2D
onready var tween = $Tween
export var speed = 3
var current_location = Vector2.ONE
onready var current_anim = $AnimFront
var dupa = null
var move = false
var tile_size = 16
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	set_process(true)
	
func _process(delta):	
	if(!$Tween.is_active()):
		current_anim.playing = false
	if(!Inventory.dialog_visible):
		if tween.is_active():
			return
		for dir in inputs.keys():
			if Input.is_action_pressed(dir):
				move(dir)
				
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if(!Inventory.dialog_visible):
			ray.cast_to = current_location * tile_size
			ray.force_raycast_update()
			if ray.is_colliding():
				dupa = ray.get_collider()
				if(dupa.has_method("interact")) :
					dupa.interact(self)
	if event.is_action_pressed("ui_select") and !Inventory.dialog_visible:
			$Camera2D/PhoneScreen.visible = true
			$Camera2D/Basket.visible = true
			$Camera2D/Basket.refreshInventory()
	if event.is_action_released("ui_select") and !Inventory.dialog_visible:
			$Camera2D/PhoneScreen.visible =  false
			$Camera2D/Basket.visible = false

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	current_location = inputs[dir]
	Inventory.batteryLevel -= 5
	match dir:
		"ui_up":
			$AnimFront.animation = "default"
		"ui_right":
			$AnimFront.animation = "Right"
		"ui_left":
			$AnimFront.animation = "Left"
		_:
			$AnimFront.animation = "New Anim"
	if !ray.is_colliding():
		move_tween(dir)
			


func move_tween(dir):
	$AnimFront.play()
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func displayDialog(buyText):
	$Camera2D/BuyUI.visible = true
	$Camera2D/BuyUI/Option1.text = Inventory.possibleItems[Inventory.currentGood][0]
	$Camera2D/BuyUI/Option2.text = Inventory.possibleItems[Inventory.currentGood][1]
	$Camera2D/BuyUI/Option3.text = Inventory.possibleItems[Inventory.currentGood][2]
	$Camera2D/BuyUI/BuyText.text = buyText
	Inventory.dialog_visible = true

func _on_Option1_button_down():
	Inventory.dialog_visible = false
	$Camera2D/BuyUI.visible = false
	if (!Inventory.currentGood in Inventory.currentInventory.keys()):
		Inventory.currentInventory[Inventory.currentGood] = [$Camera2D/BuyUI/Option1.text]
	else:
		Inventory.currentInventory[Inventory.currentGood].append($Camera2D/BuyUI/Option1.text)


func _on_Option2_button_down():
	Inventory.dialog_visible = false
	$Camera2D/BuyUI.visible = false
	if (!Inventory.currentGood in Inventory.currentInventory.keys()):
		Inventory.currentInventory[Inventory.currentGood] = [$Camera2D/BuyUI/Option2.text]
	else:
		Inventory.currentInventory[Inventory.currentGood].append($Camera2D/BuyUI/Option2.text)


func _on_Option3_button_down():
	Inventory.dialog_visible = false
	$Camera2D/BuyUI.visible = false
	if (!Inventory.currentGood in Inventory.currentInventory.keys()):
		Inventory.currentInventory[Inventory.currentGood] = [$Camera2D/BuyUI/Option3.text]
	else:
		Inventory.currentInventory[Inventory.currentGood].append($Camera2D/BuyUI/Option3.text)
