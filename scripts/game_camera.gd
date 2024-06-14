extends Camera2D

@export var shakeNoise: FastNoiseLite
@export var background_color: Color
var playerPos = Vector2.ZERO

var xNoisePos = Vector2.ZERO
var yNoisePos = Vector2.ZERO
var noiseLevel = 500
var maxShakeOffset = 10
var currentShakePercentage = 0

func apply_shake(percentage):
	currentShakePercentage = clamp(currentShakePercentage + percentage,0,1)

func _ready():
	RenderingServer.set_default_clear_color(background_color)
	
func _process(delta):
	get_player_pos()
	global_position = lerp(playerPos, global_position, pow(2, -11*delta))
	
	if currentShakePercentage > 0:
		xNoisePos += Vector2.LEFT * noiseLevel * delta
		yNoisePos += Vector2.DOWN * noiseLevel * delta
		var xSample = shakeNoise.get_noise_2d(xNoisePos.x, xNoisePos.y)
		var ySample = shakeNoise.get_noise_2d(yNoisePos.x, yNoisePos.y)
		
		offset = Vector2(xSample, ySample) * maxShakeOffset * pow(currentShakePercentage, 2)
		currentShakePercentage = clamp(currentShakePercentage - 3 * delta, 0 , 1)
			
func get_player_pos():
	var players = get_tree().get_nodes_in_group("Player")
	var deaths = get_tree().get_nodes_in_group("playerDeath")
	
	if players.size() > 0:
		var player = players[0]
		playerPos = player.global_position
	elif deaths.size() > 0:
		playerPos = deaths[deaths.size()-1].global_position
	
