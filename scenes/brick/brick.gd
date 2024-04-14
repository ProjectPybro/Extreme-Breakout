extends StaticBody2D
class_name Brick

signal brick_destroyed

@export var health = 1
var worth_in_points = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func remove_health():
	health -= 1
	if health <= 0:
		queue_free()
		brick_destroyed.emit()


## TODO: When brick dies, send a signal to the World node to increase the score
## TODO: Add a respawning mechanic
## TODO: Add different colored bricks with different hp's
## TODO: Do we want composition or is that too much?
	
	
