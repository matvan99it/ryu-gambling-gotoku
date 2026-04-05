extends Node2D

@export var tot := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Money/money_tot.text = "%d $" % [tot]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/BlackJack.tscn")


func _on_money_pressed():
	tot += 100
	$Money/money_tot.text = "%d $" % [tot]
