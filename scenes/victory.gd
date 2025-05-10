extends CanvasLayer

@onready var credits = $credits

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	credits.visible = !credits.visible


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
