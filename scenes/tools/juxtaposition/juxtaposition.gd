extends Control

@onready var container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer

var line_count: int = 0

func get_amount_of_lines() -> int:
	var file = FileAccess.open("res://scenes/tools/juxtaposition/words.txt", FileAccess.READ)
	while not file.eof_reached():
		file.get_line()
		line_count += 1
	file.close()
	return line_count

func get_random_word() -> String:
	var file = FileAccess.open("res://scenes/tools/juxtaposition/words.txt", FileAccess.READ)
	file.seek(0)  # Reset to the beginning of the file
	var random_line_number = randi() % line_count
	for i in range(random_line_number):
		file.get_line()  # Skip lines until the random line
	var random_word = file.get_line().strip_edges()
	file.close()
	return random_word

func _ready():
	line_count = get_amount_of_lines()

func _on_add_button_pressed():
	var row = preload("res://scenes/tools/juxtaposition/row.tscn").instantiate()
	container.add_child(row)
	var last_index = container.get_child_count() - 1
	container.move_child(row, last_index - 1)
