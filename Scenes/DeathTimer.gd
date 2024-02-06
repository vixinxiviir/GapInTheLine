extends Timer

func _ready():
	start()

func _process(delta):
	var antState = get_parent()._mState
	if antState == get_parent().movementStates.IDLE:
		paused = false
	else: 
		paused = true
