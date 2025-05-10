extends CanvasLayer


@onready var creds = $credits
var deadtimer = 0.0
var paused_req = false
var is_paused = false
func _input(event: InputEvent) -> void:
	if event.is_action("pause") && deadtimer == 0.0:
		paused_req = true
		
		

func _process(delta: float) -> void:
	if paused_req:
		if is_paused:
			is_paused = false
			visible = false
			deadtimer = 1.0
			paused_req = false
			get_tree().paused = false
			creds.visible = false
		else:
			is_paused = true
			visible = true
			deadtimer = 1.0
			paused_req = false
			get_tree().paused = true
	if deadtimer != 0.0:
		deadtimer -= delta
		print(deadtimer)
		if deadtimer <= 0.0:
			deadtimer = 0.0
			print("timer done")

func _on_play_pressed() -> void:
	print("play is pressed")
	if is_paused:
		paused_req = true
	else:
		print("paused but sending?")
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	creds.visible = not creds.visible
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
