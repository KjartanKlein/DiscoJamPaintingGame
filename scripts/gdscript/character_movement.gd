extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var boy_timer = 2.0
@onready var my_sprite = $sprite
@onready var textbox = $textbox
@export var min_movement = 100
@export var max_movement = 200

func _ready() -> void:
	textbox.visible = false
#
#func _physics_process(delta: float) -> void:
	#if not is_on_floor():
		#velocity += get_gravity() * delta
		#if velocity.y > 0:
			#my_sprite.animation = "falling"
		#else:
			#my_sprite.animation = "jumping"
#
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	#var direction := Input.get_axis("left", "right")
	#
	#if direction:
		#velocity.x = direction * SPEED
		#my_sprite.flip_h = velocity.x < 0
		#if is_on_floor():
			#my_sprite.animation = "running"
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#if is_on_floor():
			#my_sprite.animation = "idle"
	#
	#move_and_slide()
#



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
	
	var got_movement: bool = false
	var movement = SPEED*delta
	var direction_x = 0.0
	var direction_y = 0.0
	if Input.is_action_pressed("left"):
		velocity.x -= movement
		direction_x = -1.0
		got_movement = true
	if Input.is_action_pressed("right"):
		velocity.x += movement
		direction_x = 1.0
		got_movement = true
	if Input.is_action_pressed("up"):
		velocity.y -= movement
		direction_y = -1.0
		got_movement = true
	if Input.is_action_pressed("down"):
		velocity.y += movement
		direction_y = 1.0
		got_movement = true
	
	if direction_x ==0.0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y ==0.0:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if abs(velocity.x) > max_movement:
		velocity.x = max_movement*direction_x
	if abs(velocity.y) > max_movement:
		velocity.y = max_movement*direction_y
		
	move_and_slide()
