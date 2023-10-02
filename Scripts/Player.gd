extends CharacterBody2D

var move_speed: float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0
var direction : int = 1
var can_double_jump : float = false
var sprite : Sprite2D

func _ready():
	sprite = get_node("Sprite2D")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true
	
	velocity.x = 0
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
		sprite.flip_h = true
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
		sprite.flip_h = false
	
	if (is_on_floor()) and Input.is_key_pressed(KEY_SPACE):
		velocity.y = -jump_force
	elif can_double_jump and Input.is_key_pressed(KEY_SPACE):
		velocity.y = -jump_force
		can_double_jump = false;
	
	move_and_slide()
	
	if global_position.y > 100:
		game_over()

func game_over():
	get_tree().reload_current_scene()
