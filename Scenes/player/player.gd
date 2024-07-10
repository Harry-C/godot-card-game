class_name Player
extends Node2D

@export var stats: CharacterStats : set = set_character_stats

@onready var player_sprite = $PlayerSprite
@onready var stats_ui = $StatsUI

#func _ready() -> void:
#	await get_tree().create_timer(4).timeout
#	take_damage(21)
#	stats.block += 17

func set_character_stats(value: CharacterStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_player()
	
func update_player() -> void:
	if not stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
		
	player_sprite.texture = stats.art
	update_stats()
	

func update_stats() -> void:
	stats_ui.update_stats(stats)
	
func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
		
	stats.take_damage(damage)
	
	if stats.health <= 0:
		queue_free()
	
	
