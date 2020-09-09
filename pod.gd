extends Node2D

var speed = 1000

func _process(delta):
	var movement = delta*Vector2(0, -speed).rotated(rotation)
	position += movement
	
	var screen_size = get_viewport_rect().size

	if position.x < 0:
		position.x = screen_size.x
	if position.y < 0:
		position.y = screen_size.y
	if position.x > screen_size.x:
		position.x = 0
	if position.y > screen_size.y:
		position.y = 0
