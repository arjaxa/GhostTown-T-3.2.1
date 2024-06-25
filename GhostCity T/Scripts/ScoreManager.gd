extends Node

var score = 0

func _ready():
	set_process(true)
	
func _process(delta):
	score += delta 
	
func get_score():
	return score
