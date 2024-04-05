extends CharacterBody2D

@export var speed = 500 
# Export allows me to change the speed during the editor

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	var width = get_viewport().get_visible_rect().size[0]
	position = Vector2(width/2 , 300)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
			
func _physics_process(delta):
	if Input.is_action_pressed("left"):
		position += Vector2(-1, 0) * speed * delta
		
	if Input.is_action_pressed("right"):
		position += Vector2(1, 0) * speed * delta
		
	move_and_slide() # This deals with wall collision
	
	for loop in get_slide_collision_count():
		var collision = get_slide_collision(loop)
		if collision.get_collider() is Ball:
			collision.get_collider().apply_central_impulse(Vector2(10, -50))
		#	ball.get_collider().apply_central_impulse(ball.get_normal() * 500)

	#var direction = Input.get_vector("left", "right", "up", "down")
	#position += direction * speed * delta
	# This would be great if I wanted to go every direction
