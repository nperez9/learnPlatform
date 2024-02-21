extends CharacterBody2D

@export var defaultDirection : bool = true
@export var move_speed: float = 100.0
@export var jump_force : float = 200.0

const MAX_JUMPS = 2

var gravity : float = 500.0
var sprite : AnimatedSprite2D
var jump_effect: AnimatedSprite2D
var score : int = 0
var jumps : int = 0
var animation_lock : bool = false

@onready var score_coin_text : Label = get_node("CanvasLayer/ScoreCoin")

func _ready():
	sprite = get_node("AnimatedSprite2D")
	jump_effect = $JumpEffect
	jump_effect.visible = false
	sprite.flip_h = defaultDirection

func _physics_process(delta):
	velocity.x = 0
	
	## Ground Movement/animation manager
	if Input.is_action_pressed("mode_left"):
		velocity.x -= move_speed
		flip_sprite(!defaultDirection)
		change_animation("walk")
	elif Input.is_action_pressed("move_right"):
		velocity.x += move_speed
		flip_sprite(defaultDirection)
		change_animation("walk")
	else: 
		change_animation("idle")
	
	## Jumping | falling
	if is_on_floor():
		jumps = MAX_JUMPS

	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = -jump_force
		if not is_on_floor():
			jumps -= 2
			change_animation("double_jump")
			animation_lock = true
		else:
			jumps -= 1
	
	if not is_on_floor():
		velocity.y += gravity * delta
		change_animation("jump")
		
	move_and_slide()
	check_lose_condition()

func flip_sprite(direction: bool):
	sprite.flip_h = direction

func check_lose_condition():
	if global_position.y > 350:
		game_over()

func get_power_up():
	pass

func game_over():
	get_tree().call_deferred("reload_current_scene")
	
func add_score(amount: int):
	score += amount
	score_coin_text.text = str(score)

func change_animation(animationKey: String):
	if !animation_lock:
		sprite.play(animationKey)

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "double_jump":
		animation_lock = false

