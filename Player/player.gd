extends CharacterBody2D

#better exports
@export_range(0.01, 0.5, 0.01) var accel := 0.1
@export_range(50, 1000, 10) var maxSpeed := 100.0
var direction: Vector2


func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_vector := Vector2.ZERO

	input_vector = Input.get_vector("left","right","up","down")

	
	input_vector = input_to_dir(input_vector)

	direction = direction.lerp(input_vector, accel)

	velocity = direction * maxSpeed  * delta * 60.0
	move_and_slide()
	



func input_to_dir(input: Vector2) -> Vector2:
	
	# makes sure to keep analog input
	# and keep the speed maximum normalized
	
	if input.x <= 0.0: 
		input.x = max(input.x, input.normalized().x)
	else:
		input.x = min(input.x, input.normalized().x)
		
		
	if input.y <= 0.0: 
		input.y = max(input.y, input.normalized().y)
	else:
		input.y = min(input.y, input.normalized().y)
	
	return input
