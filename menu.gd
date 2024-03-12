extends VBoxContainer
@onready var back=$"../../CanvasLayer2/ColorRect"

func _ready():
	set_visible(false)
	
func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		set_visible(true)
		back.set_visible(true)
