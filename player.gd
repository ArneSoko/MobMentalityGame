extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
@export var jump_str = 10
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 10

var target_velocity = Vector3.ZERO
		
func _physics_process(delta):
	if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		var direction = Vector3.ZERO
		direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		direction.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
		direction = direction.normalized()
		
		var movement_direction = Vector3.ZERO
		if direction != Vector3.ZERO:
			movement_direction = direction.rotated(Vector3.UP, 
									$CameraYaw.rotation.y)
			$Pivot.look_at(self.position - movement_direction, 
							Vector3.UP)
			# Ground Velocity
			target_velocity.x = -movement_direction.x * speed
			target_velocity.z = -movement_direction.z * speed
			# Moving the Character
			velocity = target_velocity
			move_and_slide()

		# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		velocity = target_velocity
		move_and_slide()
	elif Input.get_action_strength("jump"):
		target_velocity.y = Input.get_action_strength("jump") * jump_str
		velocity = target_velocity
		move_and_slide()
