extends Resource
class_name Mazzo

var carte: Array[Card] = []

func _init(shuffle:=true):
	create_deck()
	if shuffle:
		shuffle_deck()

func create_deck():
	for seme in Card.Seme.values():
		for i in range(1,14):
			carte.append( Card.new(seme, i) )
			
func shuffle_deck():
	carte.shuffle()

func draw_card() -> Card:
	if carte.is_empty():
		return null
	return carte.pop_back()
			
func multiple_draw(n: int) -> Array[Card]:
	var res: Array[Card] = []
	for i in range(n):
		var c = draw_card()
		if c:
			res.append(c)
	return res

func size() -> int:
	return carte.size()
