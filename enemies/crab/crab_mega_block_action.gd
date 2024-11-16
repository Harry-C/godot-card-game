extends EnemyAction

@export var block := 15

# Used to perform this action only once per battle
var action_performed := false

func is_performable() -> bool:
	if not enemy or action_performed:
		return false	
	if enemy.stats.health <= enemy.stats.starting_health / 2.0:
		action_performed = true
	return action_performed

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy])
	
	# Do not immediately finish, wait a bit first to 
	# show to the player block has been applied
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
