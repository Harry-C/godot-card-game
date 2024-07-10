class_name Enemy

extends Area2D

const ARROW_OFFSET := 5

@export var stats: Stats : set = set_enemy_stats

@onready var sprite_2d = $Sprite2D
@onready var arrow = $Arrow
@onready var stats_ui = $StatsUI

#func _ready() -> void:
#	await get_tree().create_timer(2).timeout
#	take_damage(6)
#	stats.block += 8

func set_enemy_stats(value: Stats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_enemy()
	

func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
		
	sprite_2d.texture = stats.art
	arrow.position = Vector2.UP * (sprite_2d.get_rect().size.x / 2 + (sprite_2d.get_rect().size.y / 2) + ARROW_OFFSET)
	update_stats()
	

func update_stats() -> void:
	stats_ui.update_stats(stats)
	

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
		
	stats.take_damage(damage)
	
	if stats.health <= 0:
		queue_free()
	
