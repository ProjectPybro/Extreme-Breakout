extends CharacterBody2D
class_name Ball

@export var start_speed = 100.0
@export var current_speed = 0.0
@export var max_speed = 500.0
@export var starting_direction = Vector2.ZERO
@export var velocity_watcher_normalized = Vector2.ZERO

func _ready():
	change_colour()
	current_speed = start_speed
	
	if starting_direction == Vector2.ZERO:
		velocity = Vector2(1, 0).normalized()
	else:
		velocity = starting_direction.normalized()
	
	velocity_watcher_normalized = velocity.normalized()
		
func change_colour():
	var rng = RandomNumberGenerator.new()
	modulate = Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1))


func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * current_speed * delta)
	if collision == null:
		return
	
	if collision.get_collider().name == "BottomWall":
		collision_with_bottom_wall(collision)
		return
	
	elif collision.get_collider().name == "Player":
		collision_with_player(collision)
		return
	
	elif collision.get_collider() is Brick:
		collision.get_collider().call("remove_health")
	
	basic_reflect_collision(collision)
	
func collision_with_player(collision):
	velocity = position - collision.get_collider().find_child("Anchor").get_global_position()
	## The anchor just stops me having to do complex maths while still giving decent results
	
func collision_with_bottom_wall(collision):
	queue_free()
	## FIXME: This should only happen when the ball has FULLY left the screen
	
func basic_reflect_collision(collision):
	var reflect = collision.get_remainder().bounce(collision.get_normal())
	velocity = velocity.bounce(collision.get_normal())
	velocity = velocity.normalized()
	
	if velocity.x >= -0.01 and velocity.x <= 0.01:
		velocity.x = 0
	if velocity.y >= -0.01 and velocity.y <= 0.01:
		velocity.y = 0
		
	move_and_collide(reflect)
	velocity_watcher_normalized = velocity.normalized()
	
	## HACK: So, the collisions aren't 100% accurate, so a collision that should have a velocity of
	## (1.0, 0.0), might have a velocity of (1.0, 0.002). This tiny 0.002 will cause it go
	## go completely different direction the next time it bounces.
	## For 99.9% of cases, this wont matter, but if I'm doing a newton's cradle type sincaro, 
	## it completely breaks. So, this is just a little bandaid fix as a complete fix is more 
	## trouble than its worth.
	
	## Just NOTE that it is not a perfect solution, and still fails after a while
	## if the balls are moving too fast.
	
	
	## NOTE: So, if two balls of different speeds hit each other, their speeds should be swapped
	## However, since both balls have the collision, how do you swap them?
	## You could just used the inbuild ID system, but since sometimes only one ball registers the hit
	## (If a faster ball hits a slower one when they are both moving the same direction, 
	## The slower balls "move and collide" doesn't register the collision.

	## BUG: Sometimes the balls collide for 2 frames in a row, which leads to weird stuttering effect
	
	## TODO: Update README with bounce		
	## TODO: Add Rotation to the Balls?
	## TODO: Balls should speed up on collison, all the way until a max speed (1000?)
