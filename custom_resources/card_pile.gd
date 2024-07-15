class_name CardPile
extends Resource

signal card_pile_size_changed(cards_amount)

@export var cards: Array[Card] =  []

func cards_empty() -> bool:
	return cards.is_empty()
	
func draw_card() -> Card:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card

func add_card(card: Card):
	cards.append(card)
	card_pile_size_changed.emit(cards.size())
	
func shuffle() -> void:
	cards.shuffle()
	
func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())

func total() -> int:
	return cards.size()
	
# Show cards as string
func _to_string() -> String:
	var card_string: PackedStringArray = []
	for i in cards.size():
		card_string.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(card_string)

