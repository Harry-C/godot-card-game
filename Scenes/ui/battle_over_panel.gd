class_name BattleOverPanel
extends Panel

enum Type {WIN, LOSE}

@onready var victory_label: Label = %VictoryLabel
@onready var continue_button: Button = %ContinueButton
@onready var restart_button: Button = %RestartButton
@onready var reset_statistics_button: Button = %ResetStatisticsButton

@onready var rounds_played: Label = %RoundsPlayed
@onready var most_played_card: Label = %MostPlayedCard
@onready var player_damage_dealt: Label = %PlayerDamageDealt
@onready var player_damage_taken: Label = %PlayerDamageTaken
@onready var energy_used: Label = %TotalEnergyUsed
@onready var total_cards_played: Label = %TotalCardsPlayed

func _ready() -> void:
	continue_button.pressed.connect(get_tree().reload_current_scene)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	reset_statistics_button.pressed.connect(_reset_and_reload_screen)
	Events.battle_over.connect(show_screen)
	
func show_screen(text: String, type: Type) -> void:
	victory_label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	_show_statistics()
	show()
	get_tree().paused = true

func _show_statistics() -> void:
	rounds_played.text = "Rounds played: " + str(Statistics.rounds_played)
	var most_used = Statistics.most_played_card.values().max()
	most_played_card.text = "Most played card: " + Statistics.most_played_card.find_key(most_used) + " - " + str(most_used)
	player_damage_dealt.text = "Player damage dealt: " + str(Statistics.player_damage_dealt)
	player_damage_taken.text = "Player damage taken: " + str(Statistics.player_damage_taken)
	energy_used.text = "Total energy used: " + str(Statistics.energy_used)
	total_cards_played.text = "Total cards played: " + str(Statistics.cards_played)

func _reset_and_reload_screen() -> void:
	Statistics.reset()
	_show_statistics()
