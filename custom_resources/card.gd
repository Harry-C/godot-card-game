class_name Card
extends Resource

# Resource about attrbiutes of a card

enum Type { ATTACK, SKILL, POWER }
enum Target { SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE }

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target

@export var cost: int

@export_group("Card Visuals")
@export var icon: Texture
@export var name: String
@export_multiline var tooltip: String
@export var sound: AudioStream
# Tooltip with placeholders removed from buffs
var tooltip_final: String

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY
	

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
		
	var tree := targets[0].get_tree()
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemy")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemy")
		_:
			return []

func play(targets: Array[Node], stats: CharacterStats):
	Events.card_played.emit(self)
	if stats.can_play_card(self):
		stats.energy -= cost
		
		Statistics.energy_used += cost
		if Statistics.most_played_card.has(name):
			Statistics.most_played_card[name] += 1
		else:
			Statistics.most_played_card[name] = 1
	
	
	if is_single_targeted():
		apply_effects(targets, stats)
	else:
		apply_effects(_get_targets(targets), stats)
	
func apply_effects(_targets: Array[Node], stats: CharacterStats):
	pass
