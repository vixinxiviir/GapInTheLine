extends Node2D

enum selectionMode {NONE, ANTS, FRUIT}
var _sMode : int = selectionMode.NONE
var ants = []
var antsIndex = 0
var fruits = []
var fruitsIndex = 0
var antNum = 1
var fruitNum = 1
var activeAnt : CharacterBody2D = null
var activeFruit : Polygon2D = null
var homePos = Vector2(550, 600)


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
			if child._cState == child.carryStates.AVAILABLE:
				ants.append(child)
	return(ants)
	
func switch_ant_forward():
	if len(ants) != 0:
		if activeAnt == null:
			activeAnt = ants[antsIndex]
		else:
			if antsIndex >= len(ants) - 1:
				antsIndex = 0
			else:
				antsIndex += 1
			activeAnt = ants[antsIndex]

func switch_ant_back():
	if len(ants) != 0:
		if activeAnt == null:
			activeAnt = ants[antsIndex]
		else:
			if antsIndex <= 0:
				antsIndex = len(ants) - 1
			else:
				antsIndex -= 1
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
			if child._cState == child.carriedStates.AVAILABLE:
				fruits.append(child)
	return(fruits)
	
func switch_fruit_forward():
	if len(fruits) != 0:
		if activeFruit == null:
			activeFruit = fruits[fruitsIndex]
		else:
			if fruitsIndex >= len(fruits) - 1:
				fruitsIndex = 0
			else:
				fruitsIndex += 1
			activeFruit = fruits[fruitsIndex]
		
func switch_fruit_back():
	if len(fruits) != 0:
		if activeFruit == null:
			activeFruit = fruits[fruitsIndex]
		else:
			if fruitsIndex <= 0:
				fruitsIndex = len(fruits) - 1
			else:
				fruitsIndex -= 1
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
	activeFruit._tState = activeFruit.targetedStates.TARGETED
	
func check_ant_home():
	var children = get_children()
	var spawnedAnts = []
	for child in children:
		if child is CharacterBody2D:
			spawnedAnts.append(child)
	for ant in spawnedAnts:
		if ant.isHome == true:
			spawn_ant()
			spawn_fruit()
			ant.queue_free()
	
func check_ant_dead():
	for ant in ants:
		if ant.dead == true:
			ant.queue_free()
			for fruit in fruits:
				if fruit._tState == fruit.targetedStates.UNTARGETED:
					fruit.queue_free()
					return

func spawn_ant():
	print("Timeout!")
	var antObject = load("res://Scenes/ant.tscn")
	var antInstance = antObject.instantiate()
	antInstance.set_name('ant%s' % antNum)
	antInstance.set_position(Vector2(randf_range(0, 600), randf_range(400, 600)))
	add_child(antInstance)
	antNum += 1

func spawn_fruit():
	var fruitObject = load("res://Scenes/fruit.tscn")
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
	if Input.is_action_just_pressed('switchSelectionForward'):
		if self._sMode == selectionMode.ANTS:
			switch_ant_forward()
			change_ant_state()
		elif self._sMode == selectionMode.FRUIT:
			switch_fruit_forward()
			change_fruit_state()
	elif Input.is_action_just_pressed("switchSelectionBack"):
		if self._sMode == selectionMode.ANTS:
			switch_ant_back()
			change_ant_state()
		elif self._sMode == selectionMode.FRUIT:
			switch_fruit_back()
			change_fruit_state()
		
	if Input.is_action_just_pressed('switchSelectionMode'):
		switch_selection_mode()
	
	if Input.is_action_just_pressed('fetchFruit')\
	and activeAnt != null\
	and activeFruit != null\
	and activeFruit._cState != activeFruit.carriedStates.CARRIED\
	and activeAnt._cState != activeAnt.carryStates.CARRYING:
		fetchFruit()
	check_ant_home()
	check_ant_dead()
	
func _on_timer_timeout():
	spawn_ant()
	spawn_fruit()
