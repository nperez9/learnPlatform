extends Area2D

@export var move_speed : float = 30.0
@export var move_dir : int = 1
var prev_pos_x: float

func _ready():
    prev_pos_x = global_position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    global_position.x += move_speed * move_dir * delta
    
    var right_end = $RightRayCast.is_colliding()
    var left_end = $LeftRayCast.is_colliding()
    
    if (move_dir == 1 and right_end) or (move_dir == -1 and left_end):
        move_dir *= -1
    
    if (prev_pos_x < global_position.x): 
        $AnimatedSprite2D.scale.x = -1
    else: 
        $AnimatedSprite2D.scale.x = 1
    prev_pos_x = global_position.x	
    
func _on_body_entered(body):
    if body.is_in_group("Player"):
        body.game_over()