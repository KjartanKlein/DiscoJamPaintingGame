extends Control

@onready var creds = $PanelContainer

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	creds.visible = not creds.visible
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
