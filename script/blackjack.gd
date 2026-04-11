extends Control

var deck: Mazzo
var card_scene = preload("res://scene/CardScene.tscn")          # scena della carta
var card_spritesheet = preload("res://raisorse/solo_carte.png") # spritesheet unico

var mano_player: Array[Card] = []
var mano_dealer: Array[Card] = []
var totale_player := 0
var totale_dealer := 0

# Testing spqn carte
# var start_position := Vector2(50, 50)  # punto iniziale della griglia
# var spacing_x := 65                     # distanza orizzontale tra le carte
# var spacing_y := 100                    # distanza verticale tra le righe
# var cards_per_row := 13                 # numero di carte per riga (Asso → Re)

@export var offset_y: int = 18
@export var offset_x: int = 12

func _ready():
	deck = Mazzo.new()
	mano_player = deck.multiple_draw(2)
	mano_dealer = deck.multiple_draw(2)
	totale_player = mano_player.map(func(c): return c.valore).reduce(func(acc, v): return acc + v)
	totale_dealer = mano_dealer.map(func(c): return c.valore).reduce(func(acc, v): return acc + v)
	$dealerTotal.text = str(totale_dealer)
	$playerTotal.text = str(totale_player)
	
	show_cards("player")
	show_cards("dealer")

func show_cards(subject: String):
	var x
	var y
	var carte: Array[Card]
	if subject == "player":
		x = $playerStartPos.position.x
		y = $playerStartPos.position.y
		carte = mano_player
	if subject == "dealer":
		x = $dealerStartPos.position.x
		y = $dealerStartPos.position.y
		carte = mano_dealer
		offset_x *= -1
		offset_y *= -1
		
	
	var col_count = 0
	print(carte)

	# ciclo su tutte le carte del mazzo
	for card_data in carte:
		var node = card_scene.instantiate()
		node.set_card(card_data, card_spritesheet)
		node.is_face_up = true
		node.position = Vector2(x, y)
		add_child(node)


		# sposta alla prossima colonna
		# sposta leggermente verso il basso
		y -= offset_y
		x += offset_x

	# # aggiungi la carta coperta (retro) alla fine
	# var back_card_node = card_scene.instantiate()
	# back_card_node.set_card(deck.carte[0], card_spritesheet) # placeholder valido
	# back_card_node.is_face_up = false
	# back_card_node.position = Vector2(x, y)
	# add_child(back_card_node)
