extends Node2D

var deck: Mazzo
var card_scene = preload("res://scene/CardScene.tscn")          # scena della carta
var card_spritesheet = preload("res://raisorse/solo_carte.png") # spritesheet unico

var mano_player: Array[Card] = []
var mano_dealer: Array[Card] = []
var totale_player := 0
var totale_dealer := 0

var start_position := Vector2(50, 50)  # punto iniziale della griglia
var spacing_x := 65                     # distanza orizzontale tra le carte
var spacing_y := 100                    # distanza verticale tra le righe
var cards_per_row := 13                 # numero di carte per riga (Asso → Re)

func _ready():
	deck = Mazzo.new()
	mano_player = deck.multiple_draw(2)
	mano_dealer = deck.multiple_draw(2)
	totale_player = mano_player.map(func(c): return c.valore).reduce(func(acc, v): return acc + v)
	totale_dealer = mano_dealer.map(func(c): return c.valore).reduce(func(acc, v): return acc + v)
	$dealerTotal.text = str(totale_dealer)
	$playerTotal.text = str(totale_player)
	
	show_cards_grid()

func show_cards_grid():
	var x = start_position.x
	var y = start_position.y
	var col_count = 0

	# ciclo su tutte le carte del mazzo
	for card_data in deck.carte:
		var node = card_scene.instantiate()
		node.set_card(card_data, card_spritesheet)
		node.is_face_up = true
		node.position = Vector2(x, y)
		add_child(node)


		# sposta alla prossima colonna
		x += spacing_x
		col_count += 1

		# se finisce la riga, vai a capo
		if col_count >= cards_per_row:
			col_count = 0
			x = start_position.x
			y += spacing_y

	# aggiungi la carta coperta (retro) alla fine
	var back_card_node = card_scene.instantiate()
	back_card_node.set_card(deck.carte[0], card_spritesheet) # placeholder valido
	back_card_node.is_face_up = false
	back_card_node.position = Vector2(x, y)
	add_child(back_card_node)
