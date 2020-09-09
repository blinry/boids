extends Node2D

var velocity = Vector2(0, 100)

func _ready():
	$Timer.wait_time = rand_range(10, 20)
	$Timer.start()

func _process(delta):
	velocity += separation()*4
	velocity += alignment()*0.05
	
	velocity += edge_avoid()*10
	
	if velocity.length() < 300:
		velocity *= 1.01
	
	position += delta*velocity
	rotation = velocity.angle()
		
func cohesion():
	var average = Vector2.ZERO
	var areas = $CohesionVision.get_overlapping_areas()
	if areas.size() == 0:
		return average
	for area in areas:
		var boid = area.get_parent()
		average += boid.position
	average /= areas.size()
	return (average - position)
	
func alignment():
	var average = Vector2.ZERO
	var areas = $AlignmentVision.get_overlapping_areas()
	if areas.size() == 0:
		return average
	for area in areas:
		var boid = area.get_parent()
		average += boid.velocity
	average /= areas.size()
	return (average - velocity)

func separation():
	var change = Vector2.ZERO
	for area in $SeparationVision.get_overlapping_areas():
		var boid = area.get_parent()
		var diff = (boid.position - position)
		change -= diff.normalized()
	return change

func edge_avoid():
	var screen_size = get_viewport_rect().size
	var change = Vector2.ZERO
	var edge = 200
	if position.x < edge:
		change += Vector2(1, 0)
	if position.y < edge:
		change += Vector2(0, 1)
	if position.x > screen_size.x-edge:
		change += Vector2(-1, 0)
	if position.y > screen_size.y-edge:
		change += Vector2(0, -1)
	return change

func die():
	queue_free()
