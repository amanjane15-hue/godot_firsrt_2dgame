extends Area2D

@export var game_ui: Control


func _ready() -> void:
	monitoring = true

	if not game_ui:
		game_ui = get_node_or_null("../UI/GameUI") as Control

	print("FinishLine ready: ", name)


func _on_body_entered(body: Node2D) -> void:
	print("Body entered: ", body.name)

	if body == get_node_or_null("../player") or body.is_in_group("Player"):
		print("PLAYER REACHED FINISH LINE!")

		if game_ui and game_ui.has_method("finish_level"):
			game_ui.finish_level()
		else:
			print("GameUI or finish_level() not found.")
