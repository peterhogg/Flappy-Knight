extends AnimatableBody2D

const SPEED = -300.0
@onready var initialPosition = position;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var newPosition = position.x + (SPEED * delta)
	position.x =  lerp(position.x, newPosition, 0.5)


func _on_visible_on_screen_notifier_2d_screen_exited():
	position = initialPosition
