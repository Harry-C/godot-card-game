class_name Player
extends Node2D

@export var character_stats: CharacterStats : set = set_character_stats

@onready var player_sprite = $PlayerSprite
@onready var arrow = $Arrow
@onready var stats_ui = $StatsUI

const ARROW_OFFSET := 5

func set_character_stats(value: CharacterStats) -> void:
	character_stats = value
	
	if not character_stats.stats_changed.is_connected(update_stats):
		character_stats.stats_changed.connect(update_stats)
	
	update_player()
	
func update_player() -> void:
	if not character_stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
		
	player_sprite.texture = character_stats.art
	arrow.position = Vector2.UP * (player_sprite.get_rect().size.x / 2 + (player_sprite.get_rect().size.y / 2) + ARROW_OFFSET)
	update_stats()
	

func update_stats() -> void:
	stats_ui.update_stats(character_stats)
	
func take_damage(damage: int) -> void:
	if character_stats.health <= 0:
		return
		
	character_stats.take_damage(damage)
	
	if character_stats.health <= 0:
		queue_free()
	
	
