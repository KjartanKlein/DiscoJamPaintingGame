extends CharacterBody2D

@export var marker_collection : Node2D
@export var speed : int = 300
@export var light_offsett : int = 90
@export var light_angle_offsett : int = 90
@export var killable : bool = false
var positions : Array
var current_pos :int = 0
var max_pos: int
var selected_position: Marker2D
var direction : Vector2
var idle = false
@onready var light : PointLight2D = $"PointLight2D" 
@onready var area : Area2D = $"Area2D"
@onready var sprite : AnimatedSprite2D = $"AnimatedSprite2D"
@onready var marker : Node2D = $"found_marker"

@onready var thuds : AudioStreamPlayer2D = $"thuds"
@onready var seg: AudioStreamPlayer2D = $"segway noises"

enum states { 
	Patorl,
	Hunt,
	ReturnToPatrol,
}
var distance_to_marker_thresh = 100

signal endGame()

func _ready() -> void:
	#positions = get_tree().get_nodes_in_group(marker_collection)
	positions = marker_collection.get_children()
	max_pos = len(positions)
	print(max_pos)
	current_pos = 0
	light.global_position.x = global_position.x+light_offsett
	get_next_pos()
	marker.visible = false
	pass
func start_patrol():
	print("starting patrol")
	started = true

var timer = 0.0
var started = false
func _process(delta: float) -> void:
	if !started:
		return
	if idle:
		timer -=delta
		if timer <= 0:
			idle = false
			timer = 0.0
		return
	if !seg.playing && visible:
		seg.play()
	if global_position.distance_to(selected_position.position) < distance_to_marker_thresh:
		get_next_pos()
	velocity = speed*direction
	if abs(direction.x) > abs(direction.y):
		if sprite.animation != "side":
			sprite.play("side")
		if direction.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		if direction.y > 0:
			if sprite.animation != "front":
				sprite.play("front")
		else:
			if sprite.animation != "back":
				sprite.play("back")
	light.global_position = global_position + direction*light_offsett
	var rel = light.global_position - global_position
	var angle = atan2(rel.y,rel.x)
	light.rotation = 180*angle/(3.1456) + light_angle_offsett
	area.global_position = light.global_position
	move_and_slide()
		
func get_next_pos():
	if game_over:
		print("game over")
		trigger_game_over()
		return
	current_pos +=1
	if current_pos >= max_pos:
		current_pos = 0
	idle = true
	if visible:
		thuds.play()
	timer = 5.0
	selected_position = positions[current_pos]
	print("selected position ",selected_position.name," ", current_pos, " set to ", selected_position.global_position)
	direction =  to_local(selected_position.position).normalized()
	
	pass	

var game_over = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if visible && body.name == "player" && killable:
		if body.hiding:
			return
		$"onFind".play()
		marker.visible = true
		game_over = true;
		print("game over i found you")
		body.lock_movement()
		positions.clear()
		direction = to_local(body.global_position).normalized()
		selected_position.global_position = body.global_position
	pass # Replace with function body.

func trigger_game_over():
	print("Changing scenes...")
	endGame.emit()
