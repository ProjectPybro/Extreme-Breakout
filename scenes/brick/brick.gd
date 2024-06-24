extends StaticBody2D
class_name Brick

@export var health = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	$BrickSprite.set_frame(4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func remove_health():
	if is_queued_for_deletion() == true:
		return ## I think this fixes a bug where the brick counter would go negative
		
	health -= 1
	Global.add_points.emit(1)
	
	if health <= 0:
		queue_free()
		Global.brick_destroyed.emit()
		return
	
	$BrickSprite.set_frame($BrickSprite.get_frame() - 1)
	


## TODO: Add a respawning mechanic
## TODO: Add different colored bricks with different hp's
## TODO: Brick Spawner should spawn different colored bricks
## TODO: Do we want composition or is that too much?
