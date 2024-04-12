extends Node2D

var score := 0

# 1) Load the scene
var ball_scene: PackedScene = load("res://scenes/ball/ball.tscn")
var brick_scene: PackedScene = load("res://scenes/brick/brick.tscn")
var rng = RandomNumberGenerator.new()


func _ready():
	get_node("Score").set_text("Score: 0")
	update_ball_counter()
	create_level()
	

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
	
	
## NOTE: So the maths is:
## 1) Find the center point of the screen
## 2) For every brick needed on row, take away half of the brick length and add half of the spacing length
## The reason for doing half is that it will be mirrored since we are going from the center
## Make sure you add 1 half less than you should. This is because the first brick is at the right position
## and doesn't need correcting
## 3) This gives you the left most X-Coordinate where a brick will start to spawn
## 4) Then, just add another brick every width + spacing apart
## Repeat for columns

func create_level():
	var level_1 = Level.new() ## Crashes without the .new()
	level_1.level_number = 1
	level_1.bricks_per_row = 9
	level_1.number_of_columns = 5
	level_1.spacing_between_rows = 4
	level_1.spacing_between_columns = 4
	level_1.offset_every_second_column = true
	level_1.display_information()
	
	## 1)
	var middle_of_screen_x_axis : float = (get_viewport().get_visible_rect().size[0] / 2)
	var brick_scale: float = 2.0
	var brick_length: float = 32.0 * brick_scale ## I
	var brick_height: float = 16.0 * brick_scale

	
	if level_1.bricks_per_row <= 0:
		print("\n\nERROR")
		level_1.display_information()
		assert(false, "Less than 1 brick per row isn't possible to display.")
	
	## 2) and 3)
	var starting_x_coordinate : float = middle_of_screen_x_axis	
	var offset_x : float = level_1.bricks_per_row - 1
	var per_brick_offset_x = (brick_length / 2) + (level_1.spacing_between_rows / 2) 
	# Saved for later to be used for offsetting every second column
	
	offset_x *= per_brick_offset_x
	starting_x_coordinate -= offset_x
	
	var starting_y_corrdinate : float = 100.0 ## FIXME This is just a placeholder number. Make it based on screen size
	
	
	## 4)
	var current_x_corrdinate : float = starting_x_coordinate
	var current_y_corrdinate : float = starting_y_corrdinate
	var bricks_in_row_offset := 0 ## Used when offsetting the bricks every row
	
	for columns in level_1.number_of_columns:
				
		for row in (level_1.bricks_per_row - bricks_in_row_offset):
			var new_brick = brick_scene.instantiate()
			new_brick.set_position(Vector2(current_x_corrdinate, current_y_corrdinate))
			$BrickList.add_child(new_brick)
			
			current_x_corrdinate += brick_length + level_1.spacing_between_rows
		
		current_x_corrdinate = starting_x_coordinate
		current_y_corrdinate += brick_height + level_1.spacing_between_columns
		
		if level_1.offset_every_second_column == true:
			if (int(columns)+1) % 2 == 1:
				bricks_in_row_offset = 1
				current_x_corrdinate += per_brick_offset_x
			else:
				bricks_in_row_offset = 0
				
	
	
	## FIXME: Remove level_1, let it pass in any level
	## TODO: Make this look less of a nightmare
	
	## TODO: Add a logo





