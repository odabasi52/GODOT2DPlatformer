extends CharacterBody2D

var flip_h = false

func _process(delta):	
	$Visuals.scale.x = 1 if flip_h == false else -1
	velocity.x = lerpf(0, velocity.x, pow(2, -5*delta))
	if !is_on_floor():
		velocity.y += 1500*delta
		
		
	move_and_slide()
