extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
@export var jumpStr=100
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 10
@onready var camorigin=$CamYaw
@onready var camarm=$CamYaw/CamPitch
@onready var arm=$CamYaw/CamPitch/CamArm
@onready var menu=$"../Menu/PauseMenu"

var sensitivity = 0.5

var target_velocity = Vector3.ZERO

func _ready():
	#Capture mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
func _input(event):
	#Change view distance
	if Input.is_action_pressed("Zoom_In") and arm.spring_length > 0:
		arm.spring_length -= 0.2
	elif Input.is_action_pressed("Zoom_Out"):
		arm.spring_length += 0.2
		
	#Move camera with mouse
	if event is InputEventMouseMotion and Input.mouse_mode!=Input.MOUSE_MODE_VISIBLE:
		camorigin.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		camarm.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		camarm.rotation.x = clamp(camarm.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
func _physics_process(delta):
	#If mouse is captured
	if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		#Assigned moves to axes
		var input_dir = Input.get_vector("move_left","move_right","move_forward","move_back")
		#Adjust movement direction based on camera direction
		var direction = (camorigin.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#Rotate to face forward and move
		if direction:
			$Pivot.rotation.y=camorigin.rotation.y
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		#Slow to a stop
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
		#Increase speed
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = jumpStr
		
	#If in the air, fall towards the floor. Literally gravity
	if not is_on_floor(): 
		velocity.y -= fall_acceleration
	#Execute movement
	move_and_slide()
