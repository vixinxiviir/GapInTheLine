extends Node2D

enum selectionMode {NONE, ANTS, FRUIT}
var _sMode : int = selectionMode.NONE
var ants = []
var antsIndex = 0
var fruits = []
var fruitsIndex = 0
var antNum = 3
var fruitNum = 2
var activeAnt : CharacterBody2D = null
var activeFruit : Polygon2D = null


func switch_selection_mode():
	if self._sMode == selectionMode.NONE:
		self._sMode = selectionMode.ANTS
	elif self._sMode == selectionMode.ANTS:
		self._sMode = selectionMode.FRUIT
	elif self._sMode == selectionMode.FRUIT:
		self._sMode = selectionMode.ANTS
	

func get_ants():
	var children = get_children()
	var ants = []
	for child in children:
		if child is CharacterBody2D:
			ants.append(child)
	return(ants)
	
func switch_ant():
	if activeAnt == null:
		activeAnt = ants[antsIndex]
	else:
		if antsIndex == len(ants) - 1:
			antsIndex = 0
		else:
			antsIndex += 1
		activeAnt = ants[antsIndex]
			
func change_ant_state():
	for ant in ants:
		
		if ant._sState == ant.selectionStates.SELECTED:
			ant._sState = ant.selectionStates.UNSELECTED
		if ant == activeAnt:
			ant._sState = ant.selectionStates.SELECTED
			
func get_fruits():
	var children = get_children()
	var fruits = []
	for child in children:
		if child is Polygon2D:
			fruits.append(child)
	return(fruits)
	
func switch_fruit():
	if activeFruit == null:
		activeFruit = fruits[fruitsIndex]
	else:
		if fruitsIndex == len(fruits) - 1:
			fruitsIndex = 0
		else:
			fruitsIndex += 1
		activeFruit = fruits[fruitsIndex]
		
func change_fruit_state():
	for fruit in fruits:
		if fruit._sState == fruit.selectionStates.SELECTED:
			fruit._sState = fruit.selectionStates.UNSELECTED
		if fruit == activeFruit:
			fruit._sState = fruit.selectionStates.SELECTED
	
func fetchFruit():
	activeAnt._mState = activeAnt.movementStates.GET_FRUIT
	activeAnt.targetFruit = activeFruit
	
func spawn_ant():
	print("Timeout!")
	var antObject = load("res://ant.tscn")
	var antInstance = antObject.instantiate()
	antInstance.set_name('ant%s' % antNum)
	antInstance.set_position(Vector2(randf_range(0, 600), randf_range(400, 600)))
	add_child(antInstance)
	antNum += 1

func spawn_fruit():
	var fruitObject = load("res://fruit.tscn")
	var fruitInstance = fruitObject.instantiate()
	fruitInstance.set_name('fruit%s' % fruitNum)
	fruitInstance.set_position(Vector2(randf_range(0, 600), randf_range(0, 200)))
	add_child(fruitInstance)
	fruitNum += 1

func _ready():
	ants = get_ants()
	fruits = get_fruits()

func _physics_process(delta):
	ants = get_ants()
	fruits = get_fruits()
	if Input.is_action_just_pressed('switchSelection'):
		if self._sMode == selectionMode.ANTS:
			switch_ant()
			change_ant_state()
		elif self._sMode == selectionMode.FRUIT:
			switch_fruit()
			change_fruit_state()
		
	if Input.is_action_just_pressed('switchSelectionMode'):
		switch_selection_mode()
	
	if Input.is_action_just_pressed('fetchFruit')\
	and activeAnt != null\
	and activeFruit != null:
		fetchFruit()

func _on_timer_timeout():
	spawn_ant()
	spawn_fruit()
