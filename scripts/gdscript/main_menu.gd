extends Control

@onready var creds = $credits
var delay = false
func _on_play_pressed() -> void:
	$onStart.play()
	delay = true
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	creds.visible = not creds.visible
	$"oncreds".play()
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	if delay && !$onStart.playing:
		get_tree().change_scene_to_file("res://scenes/main_game.tscn")
