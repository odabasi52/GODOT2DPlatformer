extends CanvasLayer


var collected_coin = 0
var total_coin = 0


func _ready():
	var base_levels = get_tree().get_nodes_in_group("base_level")
	if base_levels.size() > 0:
		base_levels[0].collected_coin_changed.connect(self.on_collected_coin_changed)

func on_collected_coin_changed(totalCoin, collectedCoin):
	self.total_coin = totalCoin
	self.collected_coin = collectedCoin

func _process(delta):
	$MarginContainer/HBoxContainer/CoinLabel.text = "%s/%s"%[collected_coin, total_coin]
