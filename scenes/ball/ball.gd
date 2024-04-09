extends RigidBody2D
class_name Ball

@export var speed = 300
@export var direction = Vector2.ZERO

func _ready():
	var rng = RandomNumberGenerator.new()
	modulate = Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1))
	if direction == Vector2.ZERO:
		direction = Vector2(0, -30)

func _physics_process(delta):
	global_position += direction.normalized() * speed * delta
	# NOTE: Normalised just makes it so no matter what direction you go, it still goes the same speed
	# Think moving diagonal in doom made you faster
	
	## TODO: Add Rotation to the Balls?
	## TODO: Balls should speed up on collison, all the way until a max speed (1000?)

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
		direction = position - body.get_global_position()
	elif body is Brick:
		direction = position - body.get_global_position()
		body.remove_health()
		## FIXME: While ball-brick collision works, it REALLY sucks 
		## as it goes off at weird angles
	
