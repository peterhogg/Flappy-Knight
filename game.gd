extends Node2D

var score = 0

@onready var obstacle_scene = preload("res://obstacle.tscn")

@onready var scoreLabel = $Score;
@onready var endGameCanvas = $EndGameCanvas
@onready var totalScoreLabel = $EndGameCanvas/TotalScoreLabel
@onready var timer = $SpawnTimer;
@onready var player = $Player;
@onready var obstacles = $Obstacles;

var dead = false
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	player.died.connect(_on_death)
	spawn_obstacle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	scoreLabel.text = str(score)


func _on_timer_timeout():
	spawn_obstacle()

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = Vector2(150,rng.randf_range(-4, 64))
	obstacle.passed.connect(_on_obstacle_passed)
	obstacle.died.connect(_on_death)
	obstacles.add_child(obstacle)
	


func _on_obstacle_passed():
	if(dead):
		return
	score +=1

func _on_death():
	dead = true
	timer.stop();
	scoreLabel.visible = false;
	endGameCanvas.visible = true;
	totalScoreLabel.text = "[center]Total: %s[/center]" % score
	player.isDead = true
	
func _on_play_again_button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
