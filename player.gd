extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 50
@onready var camorigin=$CamYaw
@onready var camarm=$CamYaw/CamPitch
@onready var arm=$CamYaw/CamPitch/CamArm
@onready var menu=$"../Menu/PauseMenu"

var sensitivity = 0.5

var target_velocity = Vector3.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
func _input(event):
	if Input.is_action_pressed("Zoom_In") and arm.spring_length > 0:
		arm.spring_length -= 0.2
	elif Input.is_action_pressed("Zoom_Out"):
		arm.spring_length += 0.2
		
	if event is InputEventMouseMotion and Input.mouse_mode!=Input.MOUSE_MODE_VISIBLE:
		camorigin.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		camarm.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		camarm.rotation.x = clamp(camarm.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
func _physics_process(delta):
	if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		var input_dir = Input.get_vector("move_left","move_right","move_forward","move_back")
		var direction = (camorigin.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			$Pivot.rotation.y=camorigin.rotation.y
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
		
		# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		velocity = target_velocity
	move_and_slide()
