extends CharacterBody2D

var enemy_death_scene = preload("res://scenes/enemy_death.tscn")

@export var isSpawning = true

var maxSpeed = 40
var gravity = 450
var direction = Vector2.ZERO

func _process(delta):
	if isSpawning:
		return 
		
	velocity.x = (direction * maxSpeed).x
	velocity.y += gravity*delta
	
	move_and_slide()
	
	$AnimatedSprite2D.flip_h = true if direction.x > 0 else false

func _ready():
	$goalDetector.area_entered.connect(self.on_goal_entered)
	$DeathArea.area_entered.connect(self.on_deatharea_entered)

func kill():
	var death_instance = enemy_death_scene.instantiate()
	get_parent().add_child(death_instance)
	death_instance.global_position = self.global_position
		
	queue_free()
	
func on_deatharea_entered(area2d):
	$"/root/Helpers".apply_camera_shake(0.75)
	call_deferred("kill")
	
func on_goal_entered(area2d):
	direction *= -1
