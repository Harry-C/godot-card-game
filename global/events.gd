extends Node

# Card related events

# Card Aiming
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)

# Card Playing
signal card_played(card: Card)

# Card dragging
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)

