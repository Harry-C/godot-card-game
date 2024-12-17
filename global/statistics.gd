extends Node

# General Statistics
var rounds_played := 0
var cards_played := 0

# Player Statistics
var player_damage_dealt := 0
var player_damage_taken := 0
var energy_used := 0

# Dictionary of card played and number of times played
var most_played_card := { "None": 0 }

func reset() -> void:
	Statistics.rounds_played = 0
	Statistics.cards_played = 0
	Statistics.player_damage_dealt = 0
	Statistics.player_damage_taken = 0
	Statistics.energy_used = 0
	Statistics.most_played_card = {"None": 0}

	pass
