extends RigidBody2D

var speed: int
var rotation_speed: int
var rotation_direction: int
var direction_x: float

func _ready(): # Called when the node enters the scene tree for the first time.
	var rng = RandomNumberGenerator.new()
	
	
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(100, 200)
	position = Vector2(random_x , random_y)
	
	speed = rng.randi_range(200, 500) # Number between (and including) 200, 500
	rotation_speed = rng.randi_range(40, 100)
	rotation_direction = rng.randi_range(0, 1)
	
	if rotation_direction == 0:
		rotation_direction = -1 # A very crude way of getting either 1 or -1
	
	direction_x = rng.randf_range(-1, 1)

func _process(delta):
	position += Vector2(direction_x, 0) * speed * delta
	rotation_degrees += rotation_speed * rotation_direction * delta # Use rotation degrees. Rotation works in fucking radians

func _on_body_entered(body):
	print("AHHHHHHHHHHHHHHH") # Replace with function body.
