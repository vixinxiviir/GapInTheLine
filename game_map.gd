extends Node2D

var ants = []
var antsIndex = 0
var children = []
var activeAnt : CharacterBody2D = null

func _ready():
	children = get_children()
	for child in children:
		if child is CharacterBody2D:
			ants.append(child)
			
func _physics_process(delta):
	if Input.is_action_just_pressed('switchAnt'):
		if activeAnt == null:
			activeAnt = ants[antsIndex]
		else:
			if antsIndex == len(ants) - 1:
				antsIndex = 0
			else:
				antsIndex += 1
			activeAnt = ants[antsIndex]
	for ant in ants:
		
		if ant._sState == ant.selectionStates.SELECTED:
			ant._sState = ant.selectionStates.UNSELECTED
		if ant == activeAnt:
			ant._sState = ant.selectionStates.SELECTED
		print(ant._sState)
		

	#print(activeAnt)

