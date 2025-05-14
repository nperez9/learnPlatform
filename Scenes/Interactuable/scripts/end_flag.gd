extends Area2D

@export_file("*.tscn") var next_scene
@onready var timer = $Timer

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.call_deferred("win")
		timer.start()

func go_to_next_scene():
	get_tree().change_scene_to_file(next_scene)


func _on_timer_timeout():
	call_deferred("go_to_next_scene")
