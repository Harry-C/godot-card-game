class_name Tooltip
extends PanelContainer

@export var fade_seconds := 0.5
@export var fade_timeout := 1.0

@onready var tooltip_icon: TextureRect = %TooltipIcon
@onready var tooltip_card_title: RichTextLabel = %TooltipCardTitle
@onready var tooltip_card_description: RichTextLabel = %TooltipCardDescription

var tween : Tween
var is_tooltip_visible := false
var fade_timer_created := false

var fade_timer : SceneTreeTimer

func _ready():
	Events.card_tooltip_show_requested.connect(show_tooltip)
	Events.card_tooltip_hide_requested.connect(hide_tooltip)
	
	modulate = Color.TRANSPARENT
	hide()
	
func kill_tween_if_running():
	if tween:
		tween.kill()

func create_fade_timer():
	if fade_timer_created:
		return
		
	fade_timer = get_tree().create_timer(fade_timeout, false)
	fade_timer.timeout.connect(hide_animation)
	fade_timer_created = true
	
func reset_fade_timer():
	fade_timer.timeout.disconnect(hide_animation)
	fade_timer_created = false
	create_fade_timer()
	
	
func show_tooltip(icon: Texture, cardName: String, cardDescription: String):
	#print("show tooltip %s" % cardName)
	
	is_tooltip_visible = true
	kill_tween_if_running()
	
	if fade_timer_created:
		reset_fade_timer()
	
	tooltip_icon.texture = icon
	tooltip_card_title.text = cardName
	tooltip_card_description.text = cardDescription
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds)

func hide_tooltip():	
	is_tooltip_visible = false
	create_fade_timer()

func hide_animation():
	fade_timer_created = false
	if is_tooltip_visible:
		return

	kill_tween_if_running()
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_seconds)
	tween.tween_callback(hide)
