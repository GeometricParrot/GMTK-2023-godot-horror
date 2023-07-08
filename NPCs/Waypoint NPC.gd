extends CharacterBody2D

@export var way_array: Array[Node2D] = []

var currentWaypoint: int
var direction: Vector2 = Vector2(0,0)
var accel = 0.1
@onready var flashlight = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if way_array.size() != 0 and way_array[currentWaypoint] != null:
		
		var angleToPoint = get_angle_to(way_array[currentWaypoint].global_position)
		direction = direction.lerp( Vector2.RIGHT.rotated(angleToPoint) *100, accel)
		
		velocity = direction
		flashlight.rotation = direction.angle() - PI/4
		
		if abs(way_array[currentWaypoint].global_position - global_position).length() < 30:
			if currentWaypoint != way_array.size() - 1:
				currentWaypoint += 1
			else:
				currentWaypoint = 0
		
		move_and_slide()
