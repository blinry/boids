extends Node2D

var velocity = Vector2(0, 100)

func _process(delta):
	if get_parent().average:
		velocity += cohesion()*10
	velocity += separation()
	
	velocity += edge_avoid()*500
	
	velocity *= 0.99
	
	position += delta*velocity
	rotation = velocity.angle()
		
func cohesion():
	var change = (get_parent().average-position).normalized()
	#print(change)
	return change

func separation():
	var change = Vector2.ZERO
	for boid in get_tree().get_nodes_in_group("boids"):
		var diff = (boid.position - position)
		if diff.length() < 100:
			change -= diff
	return change

func edge_avoid():
	var screen_size = get_viewport_rect().size
	var change = Vector2.ZERO
	if position.x < 100:
		change += Vector2(1, 0)
	if position.y < 100:
		change += Vector2(0, 1)
	if position.x > screen_size.x-100:
		change += Vector2(-1, 0)
	if position.y > screen_size.y-100:
		change += Vector2(0, -1)
	return change
