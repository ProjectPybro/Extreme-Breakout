extends CharacterBody2D

@export var regular_speed := 500 
@export var slow_speed := 200
@export var current_speed := regular_speed
# Export allows me to change the speed during the editor

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	var screen_width = get_viewport().get_visible_rect().size[0]
	position = Vector2(screen_width/2 , 330)
	Global.game_unpaused_check_inputs.connect(check_input_when_unpaused)
	
			
func _physics_process(delta):
	if Input.is_action_pressed("paddle_left"):
		position += Vector2(-1, 0) * current_speed * delta

	if Input.is_action_pressed("paddle_right"):
		position += Vector2(1, 0) * current_speed * delta

	move_and_slide() # This deals with wall collision
	
	## BUG: Sometimes the ball can be dragged across the screen by the paddle if it hits a moving paddle
	## if it hits a moving paddle to the side. Probally move_and_slide's fault.

func _input(event: InputEvent):
	if event.is_action_pressed("paddle_slow"):
		current_speed = slow_speed
	
	elif event.is_action_released("paddle_slow"):
		current_speed = regular_speed
	
func check_input_when_unpaused(): ## This stops keys being "stuck" when paused then unpaused
	if Input.is_action_pressed("paddle_slow"):
		current_speed = slow_speed
	else:
		current_speed = regular_speed


## NOTE: Process vs Input. Input called only when a key is pressed, physics called every frame.
## Docs say if you want a one off action (like jump), use input. 
## If you want a constant action (like move left while holding A), then use process or physics_process
