extends Area2D

const SPEED = 500.0

@export var move_down: bool

@onready var initial_position = position

func _ready() -> void:
	visible = true
	modulate = Color.WHITE
	self_modulate = Color.WHITE
	z_index = 100

	# DEBUG
	print("CAR READY: ", name)
	print("Visible: ", visible)
	print("Position: ", position)

func _process(delta: float) -> void:
	if move_down:
		position += Vector2.DOWN * SPEED * delta
	else:
		position += Vector2.UP * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = initial_position


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Collided!")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
