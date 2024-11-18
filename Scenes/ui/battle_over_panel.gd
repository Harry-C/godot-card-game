class_name BattleOverPanel
extends Panel

# 
enum Type {WIN, LOSE}

@onready var victory_label: Label = %VictoryLabel
@onready var continue_button: Button = %ContinueButton
@onready var restart_button: Button = %RestartButton

func _ready() -> void:
	continue_button.pressed.connect(get_tree().quit)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	Events.battle_over.connect(show_screen)
	
func show_screen(text: String, type: Type) -> void:
	victory_label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	show()
	get_tree().paused = true
