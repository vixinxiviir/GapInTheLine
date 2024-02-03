extends CharacterBody2D

enum movementStates {IDLE, GET_FRUIT, RETURN_HOME}
enum selectionStates {UNSELECTED, SELECTED}
var _mState : int = movementStates.IDLE
var _sState : int = selectionStates.UNSELECTED
#var targetFruit : Polygon2D = null
var children = get_children()




@export var antSpeed = 25
@onready var targetFruit = get_parent().get_node("fruit")
@onready var antPolygon : Polygon2D = get_node('Polygon2D')
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self._sState == selectionStates.SELECTED:
		antPolygon.set_color(Color(1,0,0,1))
	else:
		antPolygon.set_color(Color(0,0,0,1))
		
	if self._mState == movementStates.GET_FRUIT:
		look_at(self.targetFruit.global_position)
		var fruitDirection = global_position.direction_to(targetFruit.global_position)
		velocity = fruitDirection * antSpeed
	else:
		velocity = Vector2(0,0)
		
	move_and_slide()
		
