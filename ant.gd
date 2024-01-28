extends CharacterBody2D

@export var antSpeed = 25
@onready var ant = get_parent().get_node("Ant")
@onready var fruit = get_parent().get_node("fruit")
# Called when the node enters the scene tree for the first time.
@onready var antDirection = Vector2(
		randf_range(-1,1),
		randf_range(-1,1)
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var fruitDirection = ant.global_position.direction_to(fruit.global_position)
	velocity = fruitDirection * antSpeed
	move_and_slide()
	
