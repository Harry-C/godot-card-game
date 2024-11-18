class_name BattleUI
extends CanvasLayer

@export var stats: CharacterStats : set = _set_stats

@onready var hand: Hand = $Hand
@onready var energy_ui: EnergyUI = $EnergyUI
@onready var end_turn_button: Button = %EndTurnButton

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	end_turn_button.pressed.connect(_on_end_turn_button_pressed)
	end_turn_button.disabled = true

func _set_stats(value: CharacterStats):
	stats = value
	energy_ui.stats = value
	hand.stats = value

func _on_player_hand_drawn():
	end_turn_button.disabled = false
	
func _on_end_turn_button_pressed():
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()
	
