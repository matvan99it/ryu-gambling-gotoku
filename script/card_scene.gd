extends Node2D

@export var card_data: Card
@export var sprite_sheet: Texture2D

var is_face_up := false
var card_width := 61
var card_height := 88

func _ready():
	$Sprite2D.texture = sprite_sheet
	$Sprite2D.region_enabled = true
	$Sprite2D.region_rect = Rect2(Vector2.ZERO, Vector2(card_width, card_height))
	$Sprite2D.centered = true
	$Area2D.connect("input_event", Callable(self, "_on_card_clicked"))
	update_view()

func update_view():
	if not card_data:
		return

	var rect = Rect2()
	if is_face_up:
		# fronte: riga = seme (0-3), colonna = valore-1 (0-12)
		rect.position.x = (card_data.valore - 1) * card_width
		rect.position.y = int(card_data.seme) * card_height
	else:
		# retro: prima colonna ultima riga
		rect.position.x = 0
		rect.position.y = 4 * card_height

	rect.size = Vector2(card_width, card_height)
	$Sprite2D.region_rect = rect

func flip():
	is_face_up = !is_face_up
	update_view()

# funzione helper per impostare carta + spritesheet
func set_card(card: Card, sheet: Texture2D):
	card_data = card
	sprite_sheet = sheet
	$Sprite2D.texture = sprite_sheet
	$Sprite2D.region_enabled = true
	$Sprite2D.centered = false
	update_view()
