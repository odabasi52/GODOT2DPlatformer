extends Node2D

func _ready():
	#connect to area_entered signal 
	$Area2D.area_entered.connect(self.on_area_entered)

func on_area_entered(area2d):
	$AnimationPlayer.play("pickup")
	call_deferred("disable_area")
	
	var base_level = get_tree().get_nodes_in_group("base_level")[0]
	base_level.coin_collect()

#to avoid re-pick while inside area2d
func disable_area():
	$Area2D/CollisionShape2D.disabled = true
