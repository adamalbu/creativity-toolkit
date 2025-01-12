extends HBoxContainer

var lines: int = 0
var word_1_edited: bool = false
var word_2_edited: bool = false

@onready var juxtaposition: Node = get_node("/root/Juxtaposition")

func _on_remove_row_button_pressed():
	$".".queue_free()

func get_amount_of_lines() -> int:
	var file = FileAccess.open("res://scenes/tools/juxtaposition/words.txt", FileAccess.READ)
	while not file.eof_reached():
		file.get_line()
		lines += 1
	file.close()
	return lines
	
func _ready():
	lines = get_amount_of_lines()


func _on_randomize_button_pressed():
	if !word_1_edited:
		$Word1.text = juxtaposition.get_random_word()
	if !word_2_edited:
		$Word2.text = juxtaposition.get_random_word()

func _on_word_1_text_changed(_new_text):
	if $Word1.text != "":
		word_1_edited = true
	else:
		word_1_edited = false

func _on_word_2_text_changed(_new_text):
	if $Word2.text != "":
		word_2_edited = true
	else:
		word_2_edited = false
