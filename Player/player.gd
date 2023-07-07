extends CharacterBody2D


@export var speed := 300.0
@export var accel := 400.0
@export var friction := .25
# Get the gravity from the project settings to be synced with RigidBody nodes.



func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_vector := Vector2.ZERO
	input_vector = Input.get_vector("left","right","up","down")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity += input_vector * accel * delta
		velocity.x = clamp(velocity.x, -speed, speed)
		velocity.y = clamp(velocity.y, -speed, speed)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	print(input_vector)
	move_and_slide()
