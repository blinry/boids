extends Node2D

var last_pos

func _ready():
	pass
		
func _process(delta):
	var m = get_global_mouse_position()
	if Input.is_action_pressed("spawn"):
		var pod = preload("res://boid.tscn").instance()
		var width = 50
		pod.position = m + Vector2(rand_range(-width, width), rand_range(-width, width))
		pod.velocity = rand_range(200, 300)*(m - last_pos).normalized()
		#pod.velocity = Vector2(rand_range(-300, 300), rand_range(-300, 300))
		add_child(pod)
	last_pos = m
