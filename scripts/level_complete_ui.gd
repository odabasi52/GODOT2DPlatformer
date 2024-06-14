extends CanvasLayer

func _ready():
	$PanelContainer/MarginContainer/VBoxContainer/Button.pressed.connect(self.on_pressed)
	

func on_pressed():
	$"/root/LevelManager".next_level()

