class_name Hand

extends HBoxContainer

# Used for passing down character stats to the card_ui cards from battle parent
@export var character_stats: CharacterStats

# Used for loading in new cards
@onready var card_ui := preload("res://Scenes/Card_Ui/card_ui.tscn")


var cards_played_this_turn := 0

# Get all cards in hand and setup a signal to reattach to the hand when
# the card goes into the base state
func _ready():
	Events.card_played.connect(_on_card_played)

func draw_card(card: Card) -> void:
	var new_card := card_ui.instantiate()
	add_child(new_card)
	new_card.reparent_requested.connect(_on_reparent_requested)
	new_card.card = card
	new_card.parent = self
	new_card.character_stats = character_stats
	
func discard_card(card: CardUI) -> void:
	card.queue_free()
	
func disable_hand() -> void:
	pass
	#for card in get_children():
	#	card.disabled = true

# reparent_requested Callback function
func _on_reparent_requested(child: CardUI) -> void:
	child.reparent(self)
	print (child.index)
	var new_index := clampi( child.index, 0, get_child_count())
	move_child.call_deferred(child,new_index)

func _on_card_played(_card: Card):
	cards_played_this_turn += 1
	
# Move all hand card indexes down by one when a card is played
func move_cards(_card_played: CardUI):
	for hand_card in get_children():
		var card := hand_card as CardUI
		if card.index > _card_played.index:
			card.index -= 1
