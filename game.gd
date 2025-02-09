extends Node2D

var score = 0

@onready var obstacle_scene = preload("res://obstacle.tscn")
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = Vector2(150,rng.randf_range(-4, 64))
	obstacle.passed.connect(_on_obstacle_passed)
	add_child(obstacle)


func _on_obstacle_passed():
	score +=1
	print_debug(score)
