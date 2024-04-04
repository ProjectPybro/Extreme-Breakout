extends RigidBody2D
class_name Ball

@export var speed = 300
var direction = Vector2.ZERO

func _ready():
	var rng = RandomNumberGenerator.new()
	modulate = Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1))
	
	direction.x = -1
	direction.y = -1

func _physics_process(delta):
	global_position += direction * speed * delta


func _on_body_entered(body):
	if body.name == "LeftWall" or body.name == "RightWall":
		direction.x *= -1
	elif body.name == "TopWall" or body.name == "BottomWall":
		direction.y *= -1
	elif body.name == "Player":
		direction.y *= -1

	
