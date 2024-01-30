extends CharacterBody2D

enum movementStates {IDLE, GET_FRUIT, RETURN_HOME}
enum selectionStates {UNSELECTED, SELECTED}
var _mState : int = movementStates.IDLE
var _sState : int = selectionStates.UNSELECTED


@export var antSpeed = 25
@onready var fruit = get_parent().get_node("fruit")
# Called when the node enters the scene tree for the first time.
@onready var antDirection = Vector2(
		randf_range(-1,1),
		randf_range(-1,1)
	)

func check_selection():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self._sState == selectionStates.SELECTED:
		
		look_at(fruit.global_position)
		var fruitDirection = global_position.direction_to(fruit.global_position)
		velocity = fruitDirection * antSpeed
	else:
		velocity = Vector2(0,0)
		
	move_and_slide()
		
