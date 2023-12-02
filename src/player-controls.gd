extends CharacterBody3D

var speed: int
var mouse_pos = null


func _ready():
	# Init player defaults
	speed = global.CONFIG['player']['default-speed']
	
	
func _physics_process(delta):
	velocity = Vector3.ZERO
	var direction
	
	if Input.is_action_just_pressed('click'):
		mouse_pos = get_viewport().get_mouse_position()
		
		var mouse_pos_3D: Vector3 = Vector3(mouse_pos.x, 0, mouse_pos.y)
		direction = (mouse_pos_3D - position).normalized()
		look_at(direction)
		velocity = (direction * speed)
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	
	move_and_slide()
