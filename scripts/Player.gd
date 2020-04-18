extends Area2D
onready var ray = $RayCast2D
onready var tween = $Tween
export var speed = 3
var dialog_visible = false
var current_location = Vector2.ONE
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
	
	if(!dialog_visible):
		if tween.is_active():
			return
		for dir in inputs.keys():
			if Input.is_action_pressed(dir):
				move(dir)
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if(dialog_visible):
			$Camera2D/Label.text = str("")
			dialog_visible = false
		else:
			ray.cast_to = current_location * tile_size
			ray.force_raycast_update()
			if ray.is_colliding():
				dupa = ray.get_collider()
				if(dupa.has_method("interact")) :
					dupa.interact(self)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	current_location = inputs[dir]
	if !ray.is_colliding():
		move_tween(dir)


func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func show_dialog(value):
	$Camera2D/Label.text = str(value)
	dialog_visible = true
