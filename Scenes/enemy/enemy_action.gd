class_name EnemyAction

extends Node

enum Type { CONDITIONAL, CHANCE }

@export var type: Type
@export_range(0, 10) var chance_weight: int
@export var intent: Intent
@export var sound: AudioStream

@onready var accumulated_weight := 0.0

var enemy: Enemy
var target: Node2D # Usually the player

# To be inherited by enemy action implementations to determine if
# an action has met the conditions to be performed or not
# e.g. 1st turn, at half health... etc
func is_performable() -> bool:
	return false

# To be inherited by every enemy action where
# we can move the enemy to the player, perform the attack 
# and return to its starting position
func perform_action() -> void:
	pass
