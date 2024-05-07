extends Node2D

@export var live = 3
var score = 0
@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHit


var gameOverScreen = preload("res://Scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_life(live)

func _on_deathzone_area_entered(area):
	area.queue_free()
	



func _on_player_took_damage():
	live -=1
	if (live == 0):
		player.die()
		
		await get_tree().create_timer(1.5).timeout
		var gameOver_Instantiate = gameOverScreen.instantiate()
		gameOver_Instantiate.set_score(score)
		ui.add_child(gameOver_Instantiate)
	player_hit_sound.play()
	hud.set_life(live)
	
func _physics_process(delta):
	print("hello")



func _on_enemy_spawner_enemy_spawn(enemy_instance):
	add_child(enemy_instance)
	
	enemy_instance.connect("died", on_enemy_die)

func on_enemy_die():
	score += 1
	hud.set_score_label(score)
	enemy_hit_sound.play()



func _on_enemy_spawner_path_enemy_spawn(pathEnemyInstance):
	add_child(pathEnemyInstance)
	pathEnemyInstance.enemy.connect("died", on_enemy_die)
