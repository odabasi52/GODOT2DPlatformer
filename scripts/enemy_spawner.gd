extends Marker2D

enum Direction {RIGHT, LEFT}

@export var startDirection: Direction
@export var enemyScene: PackedScene

var spawnOnNextTick = false
var currentEnemyNode = null

func _ready():
	$SpawnTimer.timeout.connect(self.check_enemy_spawn)
	call_deferred("spawn_enemy")

func spawn_enemy():
	currentEnemyNode = enemyScene.instantiate()
	get_parent().add_child(currentEnemyNode)
	currentEnemyNode.global_position = self.global_position
	currentEnemyNode.direction = Vector2.RIGHT if startDirection == Direction.RIGHT else Vector2.LEFT

func check_enemy_spawn():
	if !is_instance_valid(currentEnemyNode):
		if spawnOnNextTick:
			spawn_enemy()
			spawnOnNextTick = false
		else:
			spawnOnNextTick = true
	
