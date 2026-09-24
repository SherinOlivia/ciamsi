extends Control

signal outside_tapped

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			outside_tapped.emit()
			accept_event()

	elif event is InputEventScreenTouch:
		if event.index == 0 and event.pressed:
			outside_tapped.emit()
			accept_event()
