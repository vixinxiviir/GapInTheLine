extends Polygon2D

enum selectionStates {UNSELECTED, SELECTED}
enum carriedStates {AVAILABLE, CARRIED}
enum targetedStates {UNTARGETED, TARGETED}

var _sState : int = selectionStates.UNSELECTED
var _cState : int = carriedStates.AVAILABLE
var _tState : int = targetedStates.UNTARGETED
func _ready():
	self.set_color(Color(1,1,0,1))
	
	
func _physics_process(delta):
	if self._sState == selectionStates.SELECTED:
		self.set_color(Color(0,0,1,1))
	else:
		self.set_color(Color(1,1,0,1))
