extends CharacterBody2D

enum movementStates {IDLE, GET_FRUIT, RETURN_HOME}
enum selectionStates {UNSELECTED, SELECTED}
enum carryStates {AVAILABLE, CARRYING}

var _mState : int = movementStates.IDLE
var _sState : int = selectionStates.UNSELECTED
var _cState : int = carryStates.AVAILABLE
#var targetFruit : Polygon2D = null
var children = get_children()
var homePos = Vector2(550, 600)
signal returned_home




@export var antSpeed = 50
@onready var targetFruit = get_parent().get_node("fruit")
@onready var antPolygon : Polygon2D = get_node('Polygon2D')
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if targetFruit != null and global_position.distance_to(targetFruit.global_position) < 5:
		self._mState = movementStates.RETURN_HOME
	if global_position.distance_to(homePos) < 5 and self._mState == movementStates.RETURN_HOME:
		self._mState = movementStates.IDLE
		targetFruit.queue_free()
		targetFruit = null
		returned_home.emit()
		self.queue_free()
		
	if self._sState == selectionStates.SELECTED:
		antPolygon.set_color(Color(1,0,0,1))
	else:
		antPolygon.set_color(Color(0,0,0,1))
		
	if self._mState == movementStates.GET_FRUIT:
		look_at(self.targetFruit.global_position)
		var fruitDirection = global_position.direction_to(targetFruit.global_position)
		velocity = fruitDirection * antSpeed
		
	elif self._mState == movementStates.RETURN_HOME:
		var homeDirection = global_position.direction_to(homePos)
		antPolygon.set_color(Color(0,0,0,1))
		self._cState = self.carryStates.CARRYING
		look_at(homePos)
		#look_at(homeDirection)
		velocity = homeDirection * antSpeed
		targetFruit._cState = targetFruit.carriedStates.CARRIED
		targetFruit.global_position = global_position	
		targetFruit.set_color(Color(1,1,0,1))
		
		
	else:
		velocity = Vector2(0,0)
		
	move_and_slide()
	
