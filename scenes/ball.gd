extends RigidBody2D
class_name Ball

@export var speed = 300
var direction = Vector2.ZERO

func _ready():
	var rng = RandomNumberGenerator.new()
	modulate = Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1))
	direction = Vector2(0, -30)

func _physics_process(delta):
	global_position += direction.normalized() * speed * delta
	# NOTE: Normalised just makes it so no matter what direction you go, it still goes the same speed
	# Think moving diagonal in doom made you faster


func _on_body_entered(body):
	if body.name == "LeftWall" or body.name == "RightWall":
		direction.x *= -1
	elif body.name == "TopWall":
		direction.y *= -1
	elif body.name == "BottomWall":
		queue_free() # Removes the ball from the scene
	elif body.name == "Player":
		direction = position - body.find_child("Anchor").get_global_position()
		# The anchor just stoped us having to do complex maths
	elif body is Ball:
		direction = position - body.find_child("Anchor").get_global_position()
		

	
