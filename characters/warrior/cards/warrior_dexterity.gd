extends Card

func apply_effects(targets: Array[Node], _stats: CharacterStats):
	var dexterity_effect := DexterityEffect.new()
	dexterity_effect.amount = 2
	dexterity_effect.sound = sound
	dexterity_effect.execute(targets)
