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
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []

func play(targets: Array[Node], character_stats: CharacterStats):
	Events.card_played.emit(self)
	if character_stats.can_play_card(self):
		character_stats.energy -= cost
	
	
	if is_single_targeted():
		apply_effects(targets)
	else:
		apply_effects(_get_targets(targets))
	
func apply_effects(_targets: Array[Node]):
	pass
