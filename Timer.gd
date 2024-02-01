extends Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = 15


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_stopped():
		if wait_time > 5:
			wait_time -= 1
		start()
	
