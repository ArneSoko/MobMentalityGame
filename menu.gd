extends VBoxContainer
@onready var back=$"../../Menu_Back/ColorRect"
@onready var cooldown=$Timer

func _ready():
	set_visible(false)
	
func _input(_event):
	if Input.is_action_just_pressed("ui_cancel") and not is_visible():
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		set_visible(true)
		back.set_visible(true)
		cooldown.start()
		
	elif Input.is_action_pressed("ui_cancel") and is_visible() and cooldown.is_stopped():
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		set_visible(false)
		back.set_visible(false)
