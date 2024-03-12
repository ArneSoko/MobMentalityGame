extends Button

func _ready():
	text = "Quit"
	pressed.connect(self._button_pressed)
	
func _button_pressed():
	get_tree().quit()
