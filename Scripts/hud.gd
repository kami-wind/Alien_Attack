extends Control

@onready var score = $Score

@onready var life = $LivesLeft

func set_score_label(new_score):
	score.text = "Score: " + str(new_score)
	
func set_life(amount):
	life.text = str(amount)
