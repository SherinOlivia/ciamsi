extends Panel

@export var typing_speed := 0.025

@onready var title_label: Label = $MarginContainer/VBoxContainer/TitleLabel
@onready var description_label: RichTextLabel = $MarginContainer/VBoxContainer/DescriptionLabel

var typing_id := 0
var current_tween: Tween

func _ready() -> void:
	visible = false
	mouse_filter = Control.MOUSE_FILTER_STOP

func show_info(title: String, description: String) -> void:
	typing_id += 1
	var current_id := typing_id

	title_label.text = title
	description_label.text = description
	description_label.visible_characters = 0

	visible = true
	modulate.a = 0.0
	scale = Vector2(0.96, 0.96)

	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.set_parallel(true)
	current_tween.tween_property(self, "modulate:a", 1.0, 0.2)
	current_tween.tween_property(self, "scale", Vector2.ONE, 0.2)

	for character_index in range(description.length() + 1):
		if current_id != typing_id:
			return

		description_label.visible_characters = character_index
		await get_tree().create_timer(typing_speed).timeout

func hide_info() -> void:
	typing_id += 1

	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.tween_property(self, "modulate:a", 0.0, 0.15)
	await current_tween.finished

	visible = false

func _gui_input(event: InputEvent) -> void:
	var tapped := false

	if event is InputEventMouseButton:
		tapped = (
			event.button_index == MOUSE_BUTTON_LEFT
			and event.pressed
		)

	elif event is InputEventScreenTouch:
		tapped = event.index == 0 and event.pressed

	if tapped and description_label.visible_characters < description_label.get_total_character_count():
		typing_id += 1
		description_label.visible_characters = -1
		accept_event()
