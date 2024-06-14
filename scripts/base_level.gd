extends Node

signal collected_coin_changed

var level_complete_scene = preload("res://scenes/UI/level_complete_ui.tscn")
var player_scene = preload("res://scenes/player.tscn")

var spawnPos = Vector2.ZERO
var currentPlayerNode = null
var totalCoins = 0
var collectedCoins = 0

func _ready():
	spawnPos = $Player.global_position
	register_player($Player)
	coin_total_changed(get_tree().get_nodes_in_group("coin").size())
	$Flag.player_won.connect(self.on_win)

func on_win():
	currentPlayerNode.queue_free()
	var level_complete = level_complete_scene.instantiate()
	self.add_child(level_complete)

func coin_total_changed(newTotal):
	totalCoins = newTotal
	emit_signal("collected_coin_changed", totalCoins, collectedCoins)

func coin_collect():
	collectedCoins += 1
	emit_signal("collected_coin_changed", totalCoins, collectedCoins)
	print(str(totalCoins)+"/"+ str(collectedCoins))

func register_player(player):
	currentPlayerNode = player
	currentPlayerNode.died.connect(self.on_player_died, CONNECT_DEFERRED)
	
func create_player():
	var playerInstance = player_scene.instantiate()
	add_child(playerInstance)
	move_child(playerInstance, 1)
	playerInstance.global_position = spawnPos
	register_player(playerInstance)

func on_player_died():
	currentPlayerNode.queue_free()
	var timer = get_tree().create_timer(1.3)
	await timer.timeout
	
	create_player()
