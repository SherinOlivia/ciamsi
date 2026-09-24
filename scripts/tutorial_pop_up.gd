extends Node 

@onready var tutorial_pop_up = $tutorialPopUp

func _ready():
	tutorial_pop_up.hide()

func _on_tutorial_button_pressed():
	tutorial_pop_up.show()
	print("The button was clicked successfully!") 
	tutorial_pop_up.popup_centered()
