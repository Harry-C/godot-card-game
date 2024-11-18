extends EnemyAction

@export var damage := 11

# Used to perform this action only once per battle
var action_performed := false

func is_performable() -> bool:
	if not enemy or action_performed:
		return false
	return enemy.stats.strength > 0

func perform_action() -> void:
	if not enemy or not target:
		return
	
	# We have performed this massive attack and now we rest
	action_performed = true
	
	# Create all the effects and targets for the action
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.sound = sound
	damage_effect.amount = damage

	# Move the enemy to the player, execute the attack then return the enemy
	# back to the starting position
	tween.tween_property(enemy.sprite_2d, "global_position", end, 0.75)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	tween.tween_property(enemy.sprite_2d, "global_position", start, 0.75)
	
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
