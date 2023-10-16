extends CharacterBody2D

@export var defaultDirection : bool = true
@export var move_speed: float = 100.0
@export var jump_force : float = 200.0

var gravity : float = 500.0
var can_double_jump : float = false
var sprite : AnimatedSprite2D
var score : int = 0;

@onready var score_coin_text : Label = get_node("CanvasLayer/ScoreCoin")

func _ready():
	sprite = get_node("AnimatedSprite2D")
	sprite.flip_h = defaultDirection

func _physics_process(delta):
	velocity.x = 0
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
		sprite.play("walk")
		sprite.flip_h = !defaultDirection
	elif Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
		sprite.flip_h = defaultDirection
		sprite.play("walk")
	else: 
		sprite.play("idle")
		
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play("jump")
	else:
		can_double_jump = true
	
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
	
func add_score(amount: int):
	score += amount
	score_coin_text.text = str(score)
