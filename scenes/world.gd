extends Node2D

var score := 0

# 1) Load the scene
var ball_scene: PackedScene = load("res://scenes/ball/ball.tscn")
var rng = RandomNumberGenerator.new()


func _ready():
	get_node("Score").set_text("Score: 0")
	update_ball_counter()
	
	var level_1 = Level.new() ## Crashes without the .new()
	level_1.level_number = 1
	level_1.bricks_per_row = 5
	level_1.number_of_rows = 5
	level_1.spacing_between_rows = 4
	level_1.spacing_between_columns = 4
	level_1.display_information()
	
	## FIXME: Take this code and create a proper level maker. See levels.gd
	## Use this: https://www.youtube.com/watch?v=4rWW2uvsziM
	## TODO: Add that link to the readme

func increase_score(value):
	score += value
	get_node("Score").set_text("Score: "+str(score))
	
func update_ball_counter():
	var number_of_balls = get_node("BallList").get_child_count()
	$BallCounter.set_text("Balls: "+str(number_of_balls))
	# Note: Both get_node("Node") and $Node do the same thing
	

func _on_ball_timer_timeout():
	## 2) Creates a new instance of the ball
	var ball = ball_scene.instantiate() 
	var random_x_position = rng.randf_range(100, 500)
	ball.set_position(Vector2(random_x_position, 100))

	## 3) Add ball to the scene tree
	$BallList.add_child(ball) # Adds the ball to the scene tree
	update_ball_counter()
	





