extends Node2D


@export var body_to_check : CharacterBody2D
@export var neg_body: CharacterBody2D
@export var bodies_to_disable: Array [Node2D]
@export var bodies_to_enable: Array [Node2D]

signal swaproom(on :bool)

var neg_in_room = true
var player_in_room = false

func _ready() -> void:
		for bodies in bodies_to_disable:
			bodies.visible = true
		for bodies in bodies_to_enable:
			bodies.visible = false
		neg_body.visible = true
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered", body.name)
	if body == body_to_check:
		player_in_room = true
		swaproom.emit(true)		
		for bodies in bodies_to_disable:
			bodies.visible = false
		for bodies in bodies_to_enable:
			bodies.visible = true
		if neg_in_room:
			neg_body.visible = true
		else:
			neg_body.visible = false
	if body == neg_body:
		neg_in_room = true
		if !player_in_room:
			neg_body.visible = false
		else:
			neg_body.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("left ", body.name)
	if body == body_to_check:
		player_in_room = false
		swaproom.emit(false)
		for bodies in bodies_to_disable:
			bodies.visible = true
		for bodies in bodies_to_enable:
			bodies.visible = false
		if !neg_in_room:
			neg_body.visible = true
		else:
			neg_body.visible = false
	if body == neg_body:

		neg_in_room = false
		if player_in_room:
			neg_body.visible = false
		else:
			neg_body.visible = true
