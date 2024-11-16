extends EnemyAction

@export var strength := 1

func perform_action() -> void:
	if not enemy or not target:
		return
	
	# Tween to enlarge monster to show strength
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	tween.tween_property(enemy.sprite_2d, "scale:x", 1.25, 0.1)
	tween.tween_interval(0.1)
	tween.tween_property(enemy.sprite_2d, "scale:y", 1.5, 0.1)
	tween.tween_interval(0.1)
	tween.tween_property(enemy.sprite_2d, "scale:x", 1.5, 0.1)
	tween.tween_interval(0.1)
	tween.tween_property(enemy.sprite_2d, "scale:y", 1.25, 0.1)
	tween.tween_interval(0.1)
	tween.tween_property(enemy.sprite_2d, "scale:x", 1, 0.4)
	tween.tween_property(enemy.sprite_2d, "scale:y", 1, 0.4)
	
	var power_effect := StrengthEffect.new()
	power_effect.amount = strength
	var target_array: Array[Node] = [enemy]
	power_effect.execute(target_array)
	
	# Do not immediately finish, wait a bit first to 
	# show to the player block has been applied
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
