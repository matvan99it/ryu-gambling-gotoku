extends Resource
class_name Card

enum Seme {
	FIORI,
	QUADRI,
	CUORI,
	PICHHE
}
var seme: Seme

var valore: int:
	set(v):
		if v<1 or v>13:
			push_error("Valore non valido")
		else:
			valore = v
	get:
		return valore

func _init(_seme: Seme, _valore: int):
	seme = _seme
	valore = _valore
