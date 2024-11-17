class_name Battle
extends Node2D

@export var character_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler
@onready var player: Player = $Player

func _ready() -> void:
	# Character Statistics should be set at the beginning of the run instead
	# of at the start of a battle. That way we can save gold, health and deck
	# for the whole run
	var new_character_stats: CharacterStats = character_stats.create_instance()
	new_character_stats.deck.shuffle()
	battle_ui.character_stats = new_character_stats
	player.character_stats = new_character_stats
	
	# When all enemy turns have ended, we can then start the next player turn
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	# When player turn has ended let handler clean up the players hand
	Events.player_turn_ended.connect(player_handler.end_turn)
	# After we discard our hand at the end of the turn, let the enemies perform actions
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	# If our player dies in the battle make sure to punish the player ;)
	Events.player_died.connect(_on_player_died)
	
	start_battle(new_character_stats)
	
func start_battle(character_stats_param: CharacterStats) -> void:
	print("battle has started!")
	player_handler.start_battle(character_stats_param)

func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()

func _on_enemy_handler_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		print("Victory!")

func _on_player_died() -> void:
	print("Defeated!")
