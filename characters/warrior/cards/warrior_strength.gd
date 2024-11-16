extends Card

func apply_effects(targets: Array[Node]):
	var power_effect := PowerEffect.new()
	power_effect.amount = 2
	power_effect.execute(targets)
