extends CharacterBody3D

var speed: int
# var mouse_pos = null

@onready var navigationAgent: NavigationAgent3D = $NavigationAgent3D

func _ready():
	# Init player defaults
	speed = global.CONFIG['player']['default-speed']
	$Camera3D.set_as_top_level(true)

func _input(event):
	if Input.is_action_just_pressed("click"):
		var camera = $Camera3D
		var mouse_position = get_viewport().get_mouse_position()
		
		# Raycast configuration
		var raycast_length = global.CONFIG['player']['raycast-length']
		var raycast_from = camera.project_ray_origin(mouse_position)
		var raycast_dest = raycast_from + camera.project_ray_normal(mouse_position) * raycast_length
		var raycast_space = get_world_3d().direct_space_state
		var raycast_query = PhysicsRayQueryParameters3D.new()
		
		# Raycasting
		raycast_query.from = raycast_from
		raycast_query.to = raycast_dest
		
		var result = raycast_space.intersect_ray(raycast_query)
		navigationAgent.target_position = result.position
	

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
	moveCamera()
	move_and_slide()

# Move camera with player
func moveCamera():
	var player_POS = global_transform.origin
	$Camera3D.global_transform.origin.x = player_POS.x
	$Camera3D.global_transform.origin.z = player_POS.z

# Set facing direction
func setFaceDirection(direction):
	look_at(
		Vector3(direction.x, global_position.y, direction.z), 
		Vector3.UP
	)
