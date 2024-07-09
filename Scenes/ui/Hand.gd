class_name Hand

extends HBoxContainer

# Get all cards in hand and setup a signal to reattach to the hand when
# the card goes into the base state
func _ready():
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.parent = self
		card_ui.reparent_requested.connect(_on_reparent_requested)
		
# reparent_requested Callback function
func _on_reparent_requested(child: CardUI) -> void:
	child.reparent(self)
