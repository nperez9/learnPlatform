extends CharacterBody2D

@export var defaultDirection : bool = true
@export var move_speed: float = 100.0
@export var jump_force : float = 200.0

const MAX_JUMPS = 2

var gravity : float = 500.0
var sprite : AnimatedSprite2D
var score : int = 0
var jumps : int = 0

@onready var score_coin_text : Label = get_node("CanvasLayer/ScoreCoin")

func _ready():
	sprite = get_node("AnimatedSprite2D")
	sprite.flip_h = defaultDirection

func _physics_process(delta):
	velocity.x = 0
	
	## Ground Movement/animation manager
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
	
	## Jumping | falling
	if is_on_floor():
		jumps = MAX_JUMPS

	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = -jump_force
		if not is_on_floor():
			jumps -= 2
		else:
			jumps -= 1
		if jumps == 0:
			## TODO:
			print_debug("show double jump effect")
	
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play("jump")
		
	move_and_slide()
	
	if global_position.y > 350:
		game_over()

func game_over():
	get_tree().call_deferred("reload_current_scene")
	
func add_score(amount: int):
	score += amount
	score_coin_text.text = str(score)
