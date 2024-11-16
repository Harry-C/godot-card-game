class_name StatsUI
extends HBoxContainer

@onready var health = $Health
@onready var health_image = $Health/HealthImage
@onready var health_label = %HealthLabel

@onready var block = $Block
@onready var block_image = $Block/BlockImage
@onready var block_label = %BlockLabel

@onready var strength = $Strength
@onready var strength_image = $Strength/StrengthImage
@onready var strength_label = %StrengthLabel

@onready var dexterity = $Dexterity
@onready var dexterity_image = $Dexterity/StrengthImage
@onready var dexterity_label = %DexterityLabel

func update_stats(stats: Stats):
	health_label.text = str(stats.health)
	block_label.text = str(stats.block)
	strength_label.text = str(stats.strength)
	dexterity_label.text = str(stats.dexterity)
	
	health.visible = stats.health > 0
	block.visible = stats.block > 0
	strength.visible = stats.strength > 0
	dexterity.visible = stats.dexterity > 0
