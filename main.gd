extends Node2D

var average_position
var average_velocity

func _ready():
	pass
		
func _process(delta):
	if Input.is_action_pressed("spawn"):
		var pod = preload("res://boid.tscn").instance()
		pod.position = get_global_mouse_position()
		pod.velocity = Vector2(rand_range(-300, 300), rand_range(-300, 300))
		add_child(pod)

	average_position = Vector2.ZERO
	var boids = get_tree().get_nodes_in_group("boids")
	for boid in boids:
		average_position += boid.position
	average_position = average_position/boids.size()
	
	average_velocity = Vector2.ZERO
	for boid in boids:
		average_velocity += boid.velocity
	average_velocity = average_velocity/boids.size()

