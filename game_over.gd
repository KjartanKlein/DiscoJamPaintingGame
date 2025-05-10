extends CanvasLayer

@onready var timer :Timer = $Timer

func _on_pressed() -> void:
	timer.start()
	$onClick.play()
	pass # Replace with function body.



func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	pass # Replace with function body.
