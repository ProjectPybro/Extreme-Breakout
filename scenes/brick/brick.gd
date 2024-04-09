extends StaticBody2D
class_name Brick

@export var health = 1
var worth_in_points = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	var level_1 = Level.new() ## Crashes without the .new()
	level_1.bricks_per_row = 5
	print(level_1.bricks_per_row)
	
	## FIXME: Take this code and create a proper level maker. See levels.gd
	## Use this: https://www.youtube.com/watch?v=4rWW2uvsziM
	## TODO: Add that link to the readme


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func remove_health():
	health -= 1
	if health <= 0:
		queue_free()


## TODO: When brick dies, send a signal to the World node to increase the score
## TODO: Add a respawning mechanic
## TODO: Add different colored bricks wityh different hp's
## TODO: Do we want composition or is that too much?
	
	
