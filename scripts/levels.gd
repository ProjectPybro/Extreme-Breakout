class_name Level

var number_of_columns := 0.0  # Columns - top to bottom
var bricks_per_row := 0.0
var spacing_between_rows := 0.0  # Rows - left to right
var spacing_between_columns := 0.0 # Columns - top to bottom
var level_number := 0
var offset_every_second_column := false


func display_information():
	print("This is the information for Level: " + str(level_number))
	print("Number of columns: " + str(number_of_columns))
	print("Bricks per row: " + str(bricks_per_row))
	print("Spacing Between rows: " + str(spacing_between_rows))
	print("Spacing between columns: " + str(spacing_between_columns))
	print("Offset every second column? " + str(offset_every_second_column))
