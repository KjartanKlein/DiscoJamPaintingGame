extends CharacterBody2D

@export var SPEED = 300.0
@export var boy_timer = 2.0
@onready var my_sprite = $sprite
@onready var textbox = $textbox

func _ready() -> void:
	textbox.visible = false

var timer = 0.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		textbox.visible=true
		timer = boy_timer
	
	if textbox.visible:
		timer -= delta
		if timer < 0.0:
			textbox.visible= false
			timer = 0.0
	## Movement	
	var direction_x = 0.0
	var direction_y = 0.0
	if Input.is_action_pressed("left"):
		direction_x += -1.0
	if Input.is_action_pressed("right"):
		direction_x += 1.0
	if Input.is_action_pressed("up"):
		direction_y += -1.0
	if Input.is_action_pressed("down"):
		direction_y += 1.0
	
	velocity= Vector2(direction_x, direction_y)*SPEED*delta		
	move_and_slide()
