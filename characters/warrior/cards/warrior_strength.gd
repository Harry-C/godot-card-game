extends Card

func apply_effects(targets: Array[Node]):
	var strength_effect := StrengthEffect.new()
	strength_effect.amount = 2
	strength_effect.execute(targets)
