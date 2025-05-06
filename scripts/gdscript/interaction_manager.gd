extends Node2D

@onready var label =  $cont/Label
@onready var container =  $cont


var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	var player = get_tree().get_nodes_in_group("player")
	print(player[0].name)
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func untregister_closest():
	print(can_interact)
	print(active_areas.size())
	print("rllo")
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_player_distance)
		unregister_area(active_areas[0])

func _process(delta: float) -> void:
	var player = get_tree().get_nodes_in_group("player")
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_player_distance)
		label.text = active_areas[0].hint_text
		container.global_position = player[0].global_position
		container.global_position.y -= 240
		container.global_position.x -= label.size.x / 2
		container.show()
		label.show()
	else:
		container.hide()
		label.hide()
		
		
func _sort_by_player_distance(area1: InteractionArea, area2: InteractionArea):
	var player = get_tree().get_nodes_in_group("player")
	var area1_dist = player[0].global_position.distance_to(area1.global_position)
	var area2_dist = player[0].global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist
		
	
	
func _input(event):
	if event.is_action("interact") && can_interact:
		if active_areas.size() > 0:

			label.hide()
			container.hide()
			await active_areas[0].interact.call() #async call be carefull
			
