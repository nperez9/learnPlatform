extends Control

@export var start_scene: PackedScene = load("res://Scenes/main.tscn")

func go_to_next_scene():
	get_tree().change_scene_to_packed(start_scene)

func _on_start_button_pressed():
	go_to_next_scene()
