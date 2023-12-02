extends CharacterBody3D

var speed: int
# var mouse_pos = null

@onready var navigationAgent: NavigationAgent3D = $NavigationAgent3D

func _ready():
	# Init player defaults
	speed = global.CONFIG['player']['default-speed']
	

func _input(event):
	if Input.is_action_just_pressed("click"):
		var camera = $"../Camera3D"
		var mouse_position = get_viewport().get_mouse_position()
		var raycast_length = 100
		var raycast_from = camera.project_ray_origin(mouse_position)
		var raycast_dest = raycast_from + camera.project_ray_normal(mouse_position) * raycast_length
		var raycast_space = get_world_3d().direct_space_state
		var raycast_query = PhysicsRayQueryParameters3D.new()
		
		raycast_query.from = raycast_from
		raycast_query.to = raycast_dest
		
		var result = raycast_space.intersect_ray(raycast_query)
		
		print(result)
		
		navigationAgent.target_position = result.position
		
#func _physics_process(delta):
#	velocity = Vector3.ZERO
#	var direction
# 
#	if Input.is_action_just_pressed('click'):
#		mouse_pos = get_viewport().get_mouse_position()
#
#		var mouse_pos_3D: Vector3 = Vector3(mouse_pos.x, 0, mouse_pos.y)
#		direction = (mouse_pos_3D - position).normalized()
#		look_at(direction)
#		velocity = (direction * speed)
#
#	if direction:
#		velocity.x = direction.x * speed
#		velocity.z = direction.z * speed
#	else:
#		velocity.x = move_toward(velocity.x, 0, speed)
#		velocity.z = move_toward(velocity.z, 0, speed)
#
#
#	move_and_slide()

func _process(delta):
	if navigationAgent.is_navigation_finished():
		return

	moveToPointLocation(delta)


# CUSTOM FUNCTIONS

# Move player to pointed location
func moveToPointLocation(delta):
	var targetPOS = navigationAgent.get_next_path_position()
	var direction = global_position.direction_to(targetPOS)
	
	velocity = direction * speed
	
	setFaceDirection(targetPOS)
	move_and_slide()

# Set facing direction
func setFaceDirection(direction):
	look_at(
		Vector3(direction.x, global_position.y, direction.z), 
		Vector3.UP
	)
