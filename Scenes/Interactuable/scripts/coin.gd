extends Area2D

@export var is_moving : bool = true

var bob_height : float = 5.0
var bob_speed : float = 5.0
var t : float = 0.0
# calls on ready
@onready var start_y : float = global_position.y

func _process(delta):
	if (!is_moving):
		return
	# this will make the coin bob up and down
	t += delta
	# this will make a bouncing effect
	var delta_movement : float = (sin(t * bob_speed) + 1) / 2
	global_position.y = start_y + (delta_movement * bob_height)



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(1)
		body.play_coin_sfx()
		# deletes the coin
		queue_free()
