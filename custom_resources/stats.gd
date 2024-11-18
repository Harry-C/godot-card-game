class_name Stats
extends Resource

signal stats_changed

@export var starting_health := 1
@export var starting_block := 0
@export var starting_strength := 0
@export var starting_dexterity := 0
@export var art: Texture

var health: int : set = set_health
var block: int : set = set_block

var strength: int : set = set_strength

var dexterity: int : set = set_dexterity

func set_health(value: int):
	health = clampi(value, 0, 999)
	stats_changed.emit()

func set_block(value: int):
	block = clampi(value, 0, 999)
	stats_changed.emit()
	
func set_strength(value: int):
	strength = clampi(value, 0, 999)
	stats_changed.emit()
	
func set_dexterity(value: int):
	dexterity = clampi(value, 0, 999)
	stats_changed.emit()
	
func take_damage(damage: int):
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage - block, 0, damage)
	self.block = clampi(block - initial_damage, 0, block)
	self.health -= damage

func heal(amount: int):
	if(amount <= 0):
		return
	self.health += amount
	
func defend(amount: int):
	if(amount <= 0):
		return
	self.block += amount

func add_strength(amount: int):
	if(amount <= 0):
		return
	self.strength += amount

func add_dexterity(amount: int):
	if(amount <= 0):
		return
	self.dexterity += amount

func decrease_strength(amount: int):
	if(amount <= 0):
		return
	self.strength -= amount

func decrease_dexterity(amount: int):
	if(amount <= 0):
		return
	self.dexterity -= amount

func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = starting_health
	instance.block = starting_block
	instance.strength = starting_strength
	instance.dexterity = starting_dexterity
	return instance
