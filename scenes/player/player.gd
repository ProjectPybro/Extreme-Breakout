extends CharacterBody2D

@export var speed = 500 
# Export allows me to change the speed during the editor

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	var screen_width = get_viewport().get_visible_rect().size[0]
	position = Vector2(screen_width/2 , 300)
	
			
func _physics_process(delta):
	if Input.is_action_pressed("left"):
		position += Vector2(-1, 0) * speed * delta
		
	if Input.is_action_pressed("right"):
		position += Vector2(1, 0) * speed * delta
		
	move_and_slide() # This deals with wall collision
	
	## BUG: Sometimes the ball can be dragged across the screen by the paddle if it hits a moving paddle
	## if it hits a moving paddle to the side. Probally move_and_slide's fault.
