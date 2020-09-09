extends Node2D

func _ready():
	pass

		
func _process(delta):
	if Input.is_action_pressed("spawn"):
		var pod = preload("res://boid.tscn").instance()
		pod.position = get_global_mouse_position()
		pod.velocity = Vector2(rand_range(-300, 300), rand_range(-300, 300))
		add_child(pod)
