extends Node2D

var average

func _ready():
	pass
		
func _process(delta):
	if Input.is_action_pressed("spawn"):
		var pod = preload("res://boid.tscn").instance()
		pod.position = get_global_mouse_position()
		pod.velocity = Vector2(rand_range(-300, 300), rand_range(-300, 300))
		add_child(pod)

	average = Vector2.ZERO
	var boids = get_tree().get_nodes_in_group("boids")
	for boid in boids:
		average += boid.position
	average = average/boids.size()
