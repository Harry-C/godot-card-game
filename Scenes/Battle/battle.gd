class_name Battle
extends Node2D

@export var character_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var player: Player = $Player

func _ready() -> void:
	# Character Statistics should be set at the beginning of the run instead
	# of at the start of a battle. That way we can save gold, health and deck
	# for the whole run
	var new_character_stats: CharacterStats = character_stats.create_instance()
	new_character_stats.deck.shuffle()
	battle_ui.character_stats = new_character_stats
	player.character_stats = new_character_stats
	
	# When player turn has ended let handler clean up the players hand
	Events.player_turn_ended.connect(player_handler.end_turn)
	# TODO: After hand discard at end of turn, let enemies perform actions
	Events.player_hand_discarded.connect(player_handler.start_turn)
	
	start_battle(new_character_stats)
	
func start_battle(character_stats_param: CharacterStats) -> void:
	print("battle has started!")
	
	player_handler.start_battle(character_stats_param)
	
