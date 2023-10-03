extends Area2D

@export var is_moving : bool = false

var bob_height : float = 5.0
var bob_speed : float = 5.0
var t : float = 0.0
# calls on ready
@onready var start_y : float = global_position.y

func _process(delta):
	t += delta
	
	# this will make a bouncing effect
	var d = (sin(t * bob_speed) + 1) / 2
	global_position.y = start_y + (d * bob_height)



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(1)
		# deletes the coin
		queue_free()
