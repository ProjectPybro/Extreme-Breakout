extends Node

"""
This is a global script, used largely just to connect signals across different scenes.

See this for more information: 
https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html

"""

signal ball_deleted
signal brick_destroyed
signal add_points(int)
signal game_unpaused_check_inputs
