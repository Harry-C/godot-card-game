extends Card

func apply_effects(targets: Array[Node], _stats: CharacterStats):
	var strength_effect := StrengthEffect.new()
	strength_effect.amount = 2
	strength_effect.sound = sound
	strength_effect.execute(targets)
