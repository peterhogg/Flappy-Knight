extends Node2D

var score = 0
var highscore = 0

@onready var obstacle_scene = preload("res://obstacle.tscn")

@onready var scoreLabel = $Score;
@onready var endGameCanvas = $EndGameCanvas
@onready var totalScoreLabel = $EndGameCanvas/TotalScoreLabel
@onready var highScoreLabel = $EndGameCanvas/HighScoreLabel
@onready var timer = $SpawnTimer;
@onready var player = $Player;
@onready var obstacles = $Obstacles;

var dead = false
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	load_file()
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
	if(score > highscore):
		highscore = score
		save_file(str(highscore))
	totalScoreLabel.text = "[center]Total: %s[/center]" % score
	highScoreLabel.text = "[center]Highscore: %s[/center]" % highscore
	player.isDead = true
	
func _on_play_again_button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.

func save_file(content):
	var file = FileAccess.open("user://highscore", FileAccess.WRITE)
	file.store_string(content)

func load_file():
	var file = FileAccess.open("user://highscore", FileAccess.READ)
	if(!file):
		return
	var content = file.get_as_text()
	highscore = int(content)


func _on_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
