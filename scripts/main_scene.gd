extends Node2D

@onready var outside_tap_area: Control = $UI/OutsideTapArea
@onready var info_popup: Panel = $UI/InfoPopUp

const ALTAR_POPUP_POSITION := Vector2(170, 380)
const PUA_PUI_POPUP_POSITION := Vector2(180, 1000)
const SHAKE_STICKS_POPUP_POSITION := Vector2(300, 800)

func _ready() -> void:
	$AltarButton.pressed.connect(_on_altar_pressed)
	$PuaPuiButton.pressed.connect(_on_pua_pui_pressed)
	$ShakeSticksButton.pressed.connect(_on_shake_sticks_pressed)
	$CushionButton.pressed.connect(_on_cushion_pressed)

	outside_tap_area.outside_tapped.connect(_on_outside_tapped)

	outside_tap_area.visible = false
	outside_tap_area.mouse_filter = Control.MOUSE_FILTER_STOP
	info_popup.visible = false

func _show_info_near(
	target_button: Control,
	title: String,
	description: String
) -> void:
	var target_rect := target_button.get_global_rect()
	info_popup.position = target_rect.position + Vector2(
		target_rect.size.x + 20.0,
		0.0
	)

	outside_tap_area.mouse_filter = Control.MOUSE_FILTER_STOP
	outside_tap_area.visible = true
	info_popup.show_info(title, description)

func _on_altar_pressed() -> void:
	print("ALTAR PRESSED")
	_show_info(
		ALTAR_POPUP_POSITION,
		"Dewi Kwan Im",
        "Ini adalah altar Dewi Kwan Im."
	)

func _on_pua_pui_pressed() -> void:
	print("PUAPUI PRESSED")
	_show_info(
		PUA_PUI_POPUP_POSITION,
		"Pua Pui",
        "Ini adalah pua pui, dua batu yang terbuat dari kayu. Digunakan untuk ritual ciamsi"
	)

func _on_shake_sticks_pressed() -> void:
	print("SHAKE STICKS PRESSED")
	_show_info(
		SHAKE_STICKS_POPUP_POSITION,
		"Ciamsi Shake Sticks",
        "Ini adalah Ciam yang terbuat dari bambu."
	)

func _on_cushion_pressed() -> void:
	print("CUSHION PRESSED")
	get_tree().change_scene_to_file(
        "res://scenes/cushion_start_scene.tscn"
	)

func _show_info(popup_position: Vector2, title: String, description: String) -> void:
	info_popup.position = popup_position
	outside_tap_area.visible = true
	info_popup.show_info(title, description)

func _on_outside_tapped() -> void:
	outside_tap_area.visible = false
	outside_tap_area.mouse_filter = Control.MOUSE_FILTER_IGNORE
	info_popup.hide_info()
