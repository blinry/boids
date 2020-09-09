extends Node2D

var last_pos
var color = Color(0.2, 0.2, 0.8)

func _ready():
	pass
	
func _input(event):
	if event is InputEventMouse and event.is_pressed():
		color = Color(rand_range(0.2, 1), rand_range(0.2, 1), rand_range(0.2, 1))
		
func _process(delta):
	var m = get_global_mouse_position()
	if Input.is_action_pressed("spawn"):
		var pod = preload("res://boid.tscn").instance()
		var width = 50
		pod.position = m + Vector2(rand_range(-width, width), rand_range(-width, width))
		pod.velocity = rand_range(200, 300)*(m - last_pos).normalized()
		pod.find_node("Shape").color = color
		add_child(pod)
	last_pos = m
