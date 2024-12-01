extends Control

var currentLevel: PackedScene
var level1: PackedScene = load("res://scenes/main.tscn")
var level2: PackedScene = load("res://scenes/levels/level2.tscn")
var level3: PackedScene = load("res://scenes/levels/level3.tscn")
var level4: PackedScene = load("res://scenes/levels/level4.tscn")	

## Plays after Fade OUt
func go_to_next_scene():
	get_tree().change_scene_to_packed(currentLevel)
	
func playFadeOut():
	$AnimationPlayer.play("dissapear")

func _on_start_button_pressed():
	currentLevel = level1
	playFadeOut()
	
func _on_levels_button_pressed():
	$StartScreen.visible = false
	$LevelsControl.visible = true

func _on_back_pressed():
	$LevelsControl.visible = false
	$StartScreen.visible = true


func _on_level_1_pressed():
	currentLevel = level1
	playFadeOut()

func _on_level_2_pressed():
	currentLevel = level2
	playFadeOut()

func _on_level_3_pressed():
	currentLevel = level3
	playFadeOut()

func _on_level_4_pressed():
	currentLevel = level4
	playFadeOut()
