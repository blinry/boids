extends Node2D

var velocity = Vector2(0, 100)

func _process(delta):
	if get_parent().average_position:
		velocity += cohesion()*10
	velocity += separation()*0.2
	if get_parent().average_velocity:
		velocity += alignment()*0.05
	
	velocity += edge_avoid()*50
	
	velocity *= 0.995
	
	position += delta*velocity
	rotation = velocity.angle()
		
func cohesion():
	return (get_parent().average_position-position).normalized()
	
func alignment():
	return (get_parent().average_velocity-velocity)

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
