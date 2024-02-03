extends Polygon2D

enum selectionStates {UNSELECTED, SELECTED}

var _sState : int = selectionStates.UNSELECTED
func _ready():
	self.set_color(Color(1,1,0,1))
	
	
func _physics_process(delta):
	if self._sState == selectionStates.SELECTED:
		self.set_color(Color(0,0,1,1))
	else:
		self.set_color(Color(1,1,0,1))
