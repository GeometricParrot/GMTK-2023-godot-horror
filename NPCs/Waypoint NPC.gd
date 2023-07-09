extends CharacterBody2D

@export var way_array: Array[Node2D] = []

var currentWaypoint: int
var direction: Vector2 = Vector2(0,0)
@onready var sprite = $Sprite2D



var localT = 0.0
var rng = RandomNumberGenerator.new()


@onready var rayArray: Array[RayCast2D] = [
	$PointLight2D/RayCast2D,$PointLight2D/RayCast2D6,$PointLight2D/RayCast2D3,
	$PointLight2D/RayCast2D7,$PointLight2D/RayCast2D8,$PointLight2D/RayCast2D9,
	$PointLight2D/RayCast2D2,$PointLight2D/RayCast2D4,$PointLight2D/RayCast2D5
]



@export_range(0.01, 0.5, 0.01) var accel = 0.1
@export_range(20, 300, 5) var maxSpeed = 40.0
@export var waypointThreshold = 40

@onready var flashlight = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var mytime = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	
	
	
	
	
	
	sprite.rotation = follow_waypoint(delta) - PI/4
	
	
	if patrol():	# If hits enemy
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	if fmod(localT, 1.0) < 0.1:
		sprite.flip_h  = !sprite.flip_h

func follow_waypoint(delta):
	if way_array.size() != 0 and way_array[currentWaypoint] != null:
		
		var pointPos = way_array[currentWaypoint].global_position
		direction = direction.lerp( Vector2.RIGHT.rotated(get_angle_to(pointPos)), accel)
		
		velocity = direction * maxSpeed * delta * 60
		flashlight.rotation = direction.angle() - PI/4
		
		# when close to waypoint
		if abs(pointPos - global_position).length() < waypointThreshold:
			
			if currentWaypoint > way_array.size() - 1:
				currentWaypoint -= 1
			elif currentWaypoint < 0:
				currentWaypoint += 1
			else:
				var uncertan = rng.randi_range(-1, 1)
				currentWaypoint += 1 * uncertan
				currentWaypoint = currentWaypoint
			
		return flashlight.rotation



func patrol():
	mytime +=1
	var returnMe = false
	for i in rayArray.size():
		if rayArray[i].get_collider() != null:
			if rayArray[i].get_collider().has_method("hit") and mytime > 60:
				return rayArray[i].get_collider().hit(1)
				returnMe = true
			
		
	
	localT += 0.15
	return returnMe
