extends Node2D

func _ready():
	pass

func _input(event):
	if event is InputEventMouse and event.is_pressed():
		var pod = preload("res://pod.tscn").instance()
		pod.position = event.position
		pod.rotation = rand_range(0, 2*PI)
		add_child(pod)
