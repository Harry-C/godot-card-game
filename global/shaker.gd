extends Node

func shake(thing: Node2D, strength: float, duration: float = 0.2, count: int = 10) -> void:
	if not thing:
		return
	
	var original_position = thing.position
	var shake_count := count
	var tween := create_tween()
	
	for i in shake_count:
		var shake_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		var target = original_position + strength * shake_offset
		# Every 2nd frame return shake to original position
		if i % 2 == 0:
			target = original_position
		# Divide duration by count as this step is only a fraction of the total tween
		tween.tween_property(thing, "position", target, duration / float(shake_count))
		strength *= 0.75

	# Just in case shake_count is odd we return always to the original position
	tween.finished.connect(func(): if thing: thing.position = original_position)
