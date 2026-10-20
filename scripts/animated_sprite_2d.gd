extends Area2D

@export var speed: float = 120.0
@export var direction: Vector2 = Vector2.LEFT # Change to Vector2.RIGHT if flying right

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
