extends CharacterBody2D

#better exports
@export_range(0.01, 0.5, 0.01) var accel := 0.1
@export_range(50, 1000, 10) var maxSpeed := 100.0
var direction: Vector2


@onready var animation_tree : AnimationTree = $AnimationTree
@onready var music = $"Music Controller"

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_vector := Vector2.ZERO

	input_vector = Input.get_vector("left","right","up","down")

	
	input_vector = input_to_dir(input_vector)

	direction = direction.lerp(input_vector, accel)

	velocity = direction * maxSpeed  * delta * 60.0
	move_and_slide()
	handle_animations()
	

func handle_animations() -> void:
	var dir : Vector2 = Input.get_vector("left","right","up","down").normalized()
	
	if dir != Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/slide"] = true
	else:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/slide"] = false
	
	if dir != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = dir 
		animation_tree["parameters/Slide/blend_position"] = dir
	print(velocity)

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


# magic code from the internet that make the floor make noise
func _on_tile_detector_body_shape_entered(body_rid, body, _body_shape_index, _local_shape_index):
	if body is TileMap:
		#print("step 1")
		var collided_tile  = body.get_coords_for_body_rid(body_rid)
		
		for i in body.get_layers_count():
			#print("step 2")
			var data: TileData = body.get_cell_tile_data(i, collided_tile)
			var my_song = data.get_custom_data_by_layer_id(0)
			music.play_song(my_song)
		
		
		
