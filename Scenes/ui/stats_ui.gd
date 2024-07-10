class_name StatsUI
extends HBoxContainer

@onready var health_image = $Health/HealthImage
@onready var health_label = %HealthLabel
@onready var block_image = $Block/BlockImage
@onready var block_label = %BlockLabel

func update_stats(stats: Stats):
	health_label.text = str(stats.health)
	block_label.text = str(stats.block)
	
	health_image.visible = stats.health > 0
	block_image.visible = stats.block > 0

