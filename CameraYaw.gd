extends Node3D

var camera_sensitivity = 0.01

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion and Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		var camera_rotation = event.relative * camera_sensitivity
		rotate(Vector3.DOWN, -camera_rotation.x)
		rotation_degrees.y=wrap(rotation_degrees.y, -180, 180)
		
