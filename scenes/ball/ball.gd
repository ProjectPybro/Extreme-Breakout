extends RigidBody2D
class_name Ball

@export var speed = 100
@export var direction = Vector2.ZERO

func _ready():
	var rng = RandomNumberGenerator.new()
	modulate = Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1))
	if direction == Vector2.ZERO:
		direction = Vector2(0, -1)
	ball_physics()

func _physics_process(delta):
	#linear_velocity = Vector2(0, 0)
	var collision = move_and_collide(direction.normalized() * speed * delta)
	if not collision: ## If no collision, end
		return
	else:
		direction = collision.get_normal()
		if direction.x < 0.01 and direction.x > -0.01:
			direction.x = 0
		if direction.y < 0.01 and direction.y > -0.01:
			direction.y = 0
		## HACK: This fixed a bug where the collision randomly gets a 0.0001... to its y direction
		## I have no idea why this happens, but this fixes it, so I ain't bothered.
		
		print(direction)
	
	# apply_central_force(direction.normalized() * speed)
	# global_position += direction.normalized() * speed * delta
	# NOTE: Normalised just makes it so no matter what direction you go, it still goes the same speed
	# Think moving diagonal in doom made you faster
	
	## TODO: Add Rotation to the Balls?
	## TODO: Balls should speed up on collison, all the way until a max speed (1000?)
	

func ball_physics():
	print(linear_velocity)
	#apply_central_force(direction.normalized() * speed * 100)
	
func _on_body_entered(body):
	pass
	#if body.name == "LeftWall" or body.name == "RightWall":
		#direction.x *= -1
		#ball_physics()
		#
	#elif body.name == "TopWall" or body.name == "BottomWall":
		#direction.y *= -1
		#ball_physics()
	
	#elif body.name == "BottomWall":
		#queue_free() # Removes the ball from the scene
		
		
		
	#if body.name == "LeftWall" or body.name == "RightWall":
		#direction.x *= -1
	#elif body.name == "TopWall":
		#direction.y *= -1
	#elif body.name == "BottomWall":
		#queue_free() # Removes the ball from the scene
	#elif body.name == "Player":
		#direction = position - body.find_child("Anchor").get_global_position()
		## The anchor just stoped us having to do complex maths
	#elif body is Ball:
		#pass
		###direction = position - body.get_global_position()
	#elif body is Brick:
		#direction = position - body.get_global_position()
		#body.remove_health()
		### FIXME: While ball-brick collision works, it REALLY sucks 
		### as it goes off at weird angles
	
