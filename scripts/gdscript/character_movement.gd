extends CharacterBody2D

@export var SPEED = 300.0
@export var boy_timer = 2.0
@onready var my_sprite:AnimatedSprite2D = $sprite
@onready var textbox = $textbox
@onready var light = $PointLight2D
@onready var headlight =$"headlight"

func _ready() -> void:
	textbox.visible = false
	stored_z_index = z_index

var timer = 0.0
var movement_lock = false
var hiding = false
var stored_z_index = 0

func go_hide(inn_z_index: int):
	##we want to go behind the object, and turn off the light
	z_index = inn_z_index
	print(z_index)
	light.visible = false
	headlight.visible =false
	InteractionManager.untregister_closest()
	lock_movement()
	hiding = true
	hiding_timer = 0.5
	my_sprite.play("hiding")


func getTextLoc()->Vector2:
	return textbox.global_position	
func lock_movement():
	movement_lock = true
	
var hiding_timer = 0.0

func _process(delta: float) -> void:
	light.global_position = get_global_mouse_position()
	if hiding_timer != 0:
		hiding_timer-=delta
		if hiding_timer <= 0:
			hiding_timer = 0
	if Input.is_action_just_pressed("interact"):
		if hiding and hiding_timer == 0:
			print("unlocking")
			hiding = false
			light.visible = true
			headlight.visible = true
			z_index = stored_z_index
			movement_lock = false
			rotation = 0.0
			hiding_timer = 0.5
		textbox.visible=true
		timer = boy_timer
	
	if textbox.visible:
		timer -= delta
		if timer < 0.0:
			textbox.visible= false
			timer = 0.0
	
	## Movement	
	if movement_lock:
		return
	var direction_x = 0.0
	var direction_y = 0.0
	var animation_selected = false
	var selected_animation = my_sprite.animation
	#my_sprite.play("idle")
	if Input.is_action_pressed("left"):
		direction_x += -1.0
		if my_sprite.animation == "walk_lr":
			animation_selected = true
		if !animation_selected and my_sprite.animation != "walk_lr":
			selected_animation = "walk_lr"
			animation_selected =true
		my_sprite.flip_h = true
	if Input.is_action_pressed("right"):
		direction_x += 1.0
		if my_sprite.animation == "walk_lr":
			animation_selected = true
		if !animation_selected and  my_sprite.animation != "walk_lr":
			selected_animation = "walk_lr"
			animation_selected =true
		my_sprite.flip_h = false
	if Input.is_action_pressed("up"):
		direction_y += -1.0
		
		if my_sprite.animation == "walk_up":
			animation_selected = true
		if  !animation_selected and my_sprite.animation != "walk_up":
			selected_animation = "walk_up"
			animation_selected =true
	if Input.is_action_pressed("down"):
		direction_y += 1.0
		
		if my_sprite.animation == "walk_down":
			animation_selected = true
		if  !animation_selected and my_sprite.animation != "walk_down":
			selected_animation = "walk_down"
			animation_selected= true

	if animation_selected:
		my_sprite.play(selected_animation)
	else:
		#my_sprite.stop()
		my_sprite.play("idle")
	velocity= Vector2(direction_x, direction_y)*SPEED*delta		
	move_and_slide()
