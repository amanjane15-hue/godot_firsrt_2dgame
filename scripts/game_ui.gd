extends Control

@onready var timer_label: Label = $TimerLabel
@onready var start_menu: Control = $StartMenu
@onready var win_menu: Control = $WinMenu
@onready var final_time_label: Label = $WinMenu/FinalTimeLabel
@onready var start_button: Button = $StartMenu/StartButton
@onready var restart_button: Button = $WinMenu/RestartButton

var elapsed_time: float = 0.0
var is_running: bool = false


func _ready() -> void:
	# Keep the game paused while the start menu is visible.
	get_tree().paused = true

	# Allow UI interaction while gameplay is paused.
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Connect button signals only if they aren't already connected.
	if not start_button.pressed.is_connected(_on_start_button_pressed):
		start_button.pressed.connect(_on_start_button_pressed)

	if not restart_button.pressed.is_connected(_on_restart_button_pressed):
		restart_button.pressed.connect(_on_restart_button_pressed)

	print("GameUI ready.")


func _process(delta: float) -> void:
	if is_running:
		elapsed_time += delta
		timer_label.text = "Time: %.2f s" % elapsed_time


func _on_start_button_pressed() -> void:
	print("Start button pressed.")

	start_menu.visible = false
	is_running = true

	# Resume gameplay.
	get_tree().paused = false


func finish_level() -> void:
	is_running = false
	get_tree().paused = true

	final_time_label.text = "Your Time: %.2f seconds!" % elapsed_time
	win_menu.visible = true


func _on_restart_button_pressed() -> void:
	print("Restart button pressed.")

	get_tree().paused = false
	get_tree().reload_current_scene()
