extends CharacterBody2D

signal tookDamage

@export var speed = 400

var rocket_scene = preload("res://Scenes/rocket.tscn")

@onready var rocket_container = get_node("Rocket Container")
@onready var rocket_sound = $RocketSound

#func _ready():
	#rocket_container = get_node("Rocket Container")
	#pass
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		rocket_sound.play()

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_left"):
		velocity.x = -1 * speed
	if Input.is_action_pressed("move_right"):
		velocity.x = 1 * speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -1 * speed
	if Input.is_action_pressed("move_down"):
		velocity.y = 1 * speed
	move_and_slide()
	
	var screen_sized = get_viewport_rect().size
	global_position.x = clampf(global_position.x, 0, screen_sized.x)
	global_position.y = clampf(global_position.y, 0, screen_sized.y)

func shoot():
	var rocket_instance = rocket_scene.instantiate()
	
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 60
	
	rocket_container.add_child(rocket_instance)

func takeDamage():
	emit_signal("tookDamage")

func die():
	queue_free()

