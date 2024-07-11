class_name Hand

extends HBoxContainer

var cards_played_this_turn := 0

# Get all cards in hand and setup a signal to reattach to the hand when
# the card goes into the base state
func _ready():
	Events.card_played.connect(_on_card_played)
	
	for hand_card in get_children():
		var card_ui := hand_card as CardUI
		card_ui.parent = self
		card_ui.reparent_requested.connect(_on_reparent_requested)
		
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
