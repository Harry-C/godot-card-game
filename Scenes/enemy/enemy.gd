class_name Enemy

extends Area2D

const ARROW_OFFSET := 5

@export var stats: EnemyStats : set = set_enemy_stats

@onready var sprite_2d = $Sprite2D
@onready var arrow = $Arrow
@onready var stats_ui = $StatsUI

var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction : set = set_current_action

func set_current_action(value: EnemyAction):
	current_action = value

func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		stats.stats_changed.connect(update_action)
	
	update_enemy()
	
func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()
		
	var new_action_picker: EnemyActionPicker = stats.ai.instantiate()
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	enemy_action_picker.enemy = self

func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
		
	sprite_2d.texture = stats.art
	arrow.position = Vector2.UP * (sprite_2d.get_rect().size.x / 2 + (sprite_2d.get_rect().size.y / 2) + ARROW_OFFSET)
	setup_ai()
	update_stats()	

func update_stats() -> void:
	stats_ui.update_stats(stats)
	
# Update the current action based on anything that has happened in the turn
func update_action() -> void:
	if not enemy_action_picker:
		return
	# By default get whatever action we can do
	if not current_action:
		current_action = enemy_action_picker.get_action()
		return
	# However, if a conditional action can apply during a turn then reset the action
	# to be performed to this new action instead
	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
		
	stats.take_damage(damage)
	
	if stats.health <= 0:
		queue_free()
	
func do_turn () -> void:
	stats.block = 0

	if not current_action:
		return

	current_action.perform_action()

func _on_area_entered(_area):
	arrow.show()
	

func _on_area_exited(_area):
	arrow.hide()
