extends CharacterBody2D

@export var marker_collection : Node
@export var speed : int = 300
@export var light_offsett : int = 90
@export var light_angle_offsett : int = 90

var positions : Array
var current_pos :int = 0
var max_pos: int
var selected_position: Marker2D
var direction : Vector2
var idle = false
@onready var light : PointLight2D = $"PointLight2D" 

enum states { 
	Patorl,
	Hunt,
	ReturnToPatrol,
}

func _ready() -> void:
	#positions = get_tree().get_nodes_in_group(marker_collection)
	positions = marker_collection.get_children()
	max_pos = len(positions)
	print(max_pos)
	current_pos = 0
	light.global_position.x = global_position.x+light_offsett
	get_next_pos()
	pass

var timer = 0.0
func _process(delta: float) -> void:
	if idle:
		timer -=delta
		if timer <= 0:
			idle = false
			timer = 0.0
		return
	if global_position.distance_to(selected_position.position) < 10:
		get_next_pos()
	velocity = speed*direction 
	light.global_position = global_position + direction*light_offsett
	var rel = light.global_position - global_position
	var angle = atan2(rel.y,rel.x)
	light.rotation = 180*angle/(3.1456) + light_angle_offsett
	move_and_slide()
		
func get_next_pos():
	current_pos +=1
	if current_pos >= max_pos:
		current_pos = 0
	idle = true
	timer = 5.0
	selected_position = positions[current_pos]
	print("selected position ",selected_position.name," ", current_pos, " set to ", selected_position.global_position)
	direction =  to_local(selected_position.position).normalized()
	
	pass	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("game over i found you")
	pass # Replace with function body.
