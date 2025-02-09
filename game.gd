extends Node2D

var score = 0

@onready var obstacle_scene = preload("res://obstacle.tscn")

@onready var scoreLabel = $Score;
@onready var endGameCanvas = $EndGameCanvas
@onready var timer = $SpawnTimer;
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	scoreLabel.text = str(score)


func _on_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = Vector2(150,rng.randf_range(-4, 64))
	obstacle.passed.connect(_on_obstacle_passed)
	obstacle.died.connect(_on_obstacle_died)
	add_child(obstacle)


func _on_obstacle_passed():
	score +=1

func _on_obstacle_died():
	timer.stop();
	scoreLabel.visible = false;
	endGameCanvas.visible = true;
	# get_tree().reload_current_scene()
	


