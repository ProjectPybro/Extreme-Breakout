extends Node2D

var score = 0: set = set_score ## Setter

# 1) Load the scene
var ball_scene: PackedScene = load("res://scenes/ball.tscn")

func _ready():
	get_node("Score").set_text("Score: 0")
	update_ball_counter()

func set_score(value):
	score = value
	get_node("Score").set_text("Score: "+str(score))
	## TODO: Add Score + Ball Count?
	
func update_ball_counter():
	var number_of_balls = get_node("BallList").get_child_count()
	$BallCounter.set_text("Balls: "+str(number_of_balls))
	# Note: Both get_node("Node") and $Node do the same thing


func _on_ball_timer_timeout():
	# #2) Creates a new instance of the ball
	var ball = ball_scene.instantiate() 
	ball.set_position(Vector2(100, 100))
	## TODO: Randomise the position of the ball
	## 3) Add ball to the scene tree
	$BallList.add_child(ball) # Adds the ball to the scene tree
	update_ball_counter()
	## print("Debug: Ball Spawned")




