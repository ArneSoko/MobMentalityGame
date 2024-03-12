extends Button
@onready var menu=$".."
@onready var men_back=$"../../../Menu_Back/ColorRect"

func _ready():
	text = "Close"
	pressed.connect(self._button_pressed)
	
func _button_pressed():
	get_tree().paused=false
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	men_back.set_visible(false)
	menu.set_visible(false)
