extends EnemyAction

@export var block := 15

# Used to perform this action only once per battle
var action_performed := false

func is_performable() -> bool:
	if not enemy or action_performed:
		return false
	return enemy.stats.health <= enemy.stats.starting_health / 2.0

func perform_action() -> void:
	if not enemy or not target:
		return
	
	action_performed = true
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block + enemy.stats.dexterity
	block_effect.sound = sound
	block_effect.execute([enemy])
	
	# Do not immediately finish, wait a bit first to 
	# show to the player block has been applied
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
