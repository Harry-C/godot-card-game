extends Node

# Card related events
# {

# Card Aiming
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)

# Card has been played
signal card_played(card: Card)

# Card dragging
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)

# Tooltip
signal card_tooltip_show_requested(card: Card)
signal card_tooltip_hide_requested

# }

# Player related events
# {

signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended

#unused
signal player_draw_card

# }
