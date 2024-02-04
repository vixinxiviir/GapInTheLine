extends Polygon2D

enum selectionStates {UNSELECTED, SELECTED}
enum carriedStates {AVAILABLE, CARRIED}

var _sState : int = selectionStates.UNSELECTED
var _cState : int = carriedStates.AVAILABLE
func _ready():
	self.set_color(Color(1,1,0,1))
	
	
func _physics_process(delta):
	if self._sState == selectionStates.SELECTED:
		self.set_color(Color(0,0,1,1))
	else:
		self.set_color(Color(1,1,0,1))
