@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("CharacterCreatorToolImporter", "Node", preload("res://addons/character_creator_tool_importer/character-importer.gd"), preload("res://addons/character_creator_tool_importer/character-importer.svg") )


func _exit_tree():
	remove_custom_type("CharacterCreatorToolImporter")
