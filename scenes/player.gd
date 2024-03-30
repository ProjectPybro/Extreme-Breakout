extends CharacterBody2D

@export var speed = 500 
# Export allows me to change the speed during the editor

# Called when the node enters the scene tree for the first time.
func _ready():
	var width = get_viewport().get_visible_rect().size[0]
	position = Vector2(width/2 , 300)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_pressed("left"):
		position += Vector2(-1, 0) * speed * delta
		
	if Input.is_action_pressed("right"):
		position += Vector2(1, 0) * speed * delta
		
	move_and_slide() # This deals with wall collision
		

	#var direction = Input.get_vector("left", "right", "up", "down")
	#position += direction * speed * delta
	# This would be great if I wanted to go every direction
