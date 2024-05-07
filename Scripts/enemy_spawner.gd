extends Node2D

var enemy_scene = preload("res://Scenes/enemy.tscn")
var path_enemy_scene = preload("res://Scenes/path_2d.tscn")

signal enemySpawn(enemy_instance)
signal pathEnemySpawn(pathEnemyInstance)

@onready var spawnPosition = $SpawnPosition

func _on_timer_timeout():
	spawn_enemy()


func spawn_enemy():
	var spawnPositionArray = spawnPosition.get_children()
	
	var randomSpawnPosition = spawnPositionArray.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = randomSpawnPosition.global_position
	emit_signal("enemySpawn",enemy_instance)
	#add_child(enemy_instance)


func _on_path_enemy_timer_timeout():
	spawn_path_enemy()
	
func spawn_path_enemy():
	var pathEnemyInstance = path_enemy_scene.instantiate()
	emit_signal("pathEnemySpawn", pathEnemyInstance)
