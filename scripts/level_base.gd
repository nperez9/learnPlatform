extends Node

class_name LevelBase

@export var levelMusic: AudioStream

var level_color_rect = ColorRect
var level_audio_stream = AudioStreamPlayer

func _ready():
	create_level_nodes()
	var tween = create_tween().set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(level_color_rect, "color", Color.BLACK, 1)

func create_level_nodes(): 
	level_color_rect = ColorRect.new()
	level_audio_stream = AudioStreamPlayer.new()
