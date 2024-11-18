extends Card

func apply_effects(targets: Array[Node], stats: CharacterStats):
	var block_effect := BlockEffect.new()
	block_effect.amount = 5 + stats.dexterity
	block_effect.sound = sound
	block_effect.execute(targets)
