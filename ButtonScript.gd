extends Button

func _ready():
	var button = Button.new()
	button.text = "Click me"
	button.pressed.connect(self._button_pressed)
	add_child(button)

func _button_pressed():
	print("Hello world!")
	#Read https://docs.godotengine.org/en/stable/tutorials/inputs/handling_quit_requests.html

