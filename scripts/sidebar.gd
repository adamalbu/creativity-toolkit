extends ColorRect

# Declare variable for the animation player
var animation_player: AnimationPlayer
var is_open: bool
var close_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = $AnimationPlayer
	animation_player.speed_scale = 2.0

	# Create and configure the timer
	close_timer = Timer.new()
	close_timer.wait_time = 0.1
	close_timer.one_shot = true
	close_timer.connect("timeout", self._on_close_timer_timeout)
	add_child(close_timer)

	# Connect button signals to propagate mouse events
	var buttonContainer = $MarginContainer/VBoxContainer
	for button in buttonContainer.get_children():
		button.connect("mouse_entered", self._on_button_mouse_entered)
		button.connect("mouse_exited", self._on_button_mouse_exited)

	# Connect sidebar signals
	connect("mouse_entered", self._on_sidebar_mouse_entered)
	connect("mouse_exited", self._on_sidebar_mouse_exited)

# Function to handle mouse entered event on the sidebar
func _on_sidebar_mouse_entered():
	close_timer.stop()
	if not is_open:
		animation_player.play("open")
		is_open = true

# Function to handle mouse exited event on the sidebar
func _on_sidebar_mouse_exited():
	close_timer.start()

# Function to handle mouse entered event on a button
func _on_button_mouse_entered():
	close_timer.stop()

# Function to handle mouse exited event on a button
func _on_button_mouse_exited():
	close_timer.start()

# Function to handle timer timeout
func _on_close_timer_timeout():
	if is_open:
		animation_player.play("close")
		is_open = false
