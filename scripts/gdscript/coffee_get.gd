extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var interaction_area :InteractionArea = $interaction
@onready var progress : ProgressBar = $ProgressBar
# Called when the node enters the scene tree for the first time.

var dispensing = true;
signal CoffeIsDone

func _ready() -> void:
	sprite.animation = "idle"
	interaction_area.interact  = Callable(self, "coffee_dispense")
	progress.visible = false
	pass # Replace with function body.

func  coffee_dispense()-> void:
	if sprite.animation != "dispense":
		print("making a fresh cuppa joe")
		sprite.play("dispense") 
		dispensing = true;		
		timer = 5.0
		progress.visible=true	
	else:
		print("somehow still in dispense")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
var timer = 5.0
func _process(delta: float) -> void:
	if dispensing: 
		
		timer -= delta
		progress.value = timer
		if timer <= 0.0:
			dispensing = false		
			progress.visible=false
			print("fresh cuppa over")
			sprite.play("idle")
