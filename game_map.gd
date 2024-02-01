extends Node2D

var ants = []
var antsIndex = 0
var antNum = 3
var fruitNum = 2
var children = []
var activeAnt : CharacterBody2D = null

func get_ants():
	var children = get_children()
	var ants = []
	for child in children:
		if child is CharacterBody2D:
			ants.append(child)
	return(ants)
	
func switch_ant():
	if Input.is_action_just_pressed('switchAnt'):
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
	
			
func _physics_process(delta):
	ants = get_ants()
	switch_ant()
	change_ant_state()
		

	#print(activeAnt)



func _on_timer_timeout():
	spawn_ant()
	spawn_fruit()
