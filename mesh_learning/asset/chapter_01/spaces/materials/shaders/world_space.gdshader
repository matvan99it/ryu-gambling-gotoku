shader_type spatial;

uniform sampler2D _MainTex : source_color; // variabile di tipo sampler2D con hint(?) source color
// sampler2D: 2-dimensional texture che può può essere usata nella shader
// uniform: indica che la texture è assegnata esternamente al materiale
// source_color: specifica che la texture funziona come una albedo map(base color)


vec3 hash33(vec3 p) {
	p = fract(p * 0.4567); // = px * numero -> si tiene solo la parte frazionale
	p += dot(p, p.yzx + 1.3456); // moltiplicazione tra vettori
	
	// le 3 coordinate alla seconda
	p.x *= p.x;
	p.y *= p.y;
	p.z *= p.z;
	return fract(p); // ritorna il vec3 cambiato e normalizzato(valori tra 0.0 e 1.0)
}

void vertex() {
	// Called for every vertex the material is visible on.
	/* PIPELINE vertex()
		1. Object space: spazio locale del modello, con i vertici sono definiti relativamente al pivot
		2. World space:  trasforma i vertici in base alla posizione dell'oggetto rispetto alla scena
		3. View Space:   aggiusta i vertici in base alla prospettiva della telecamera, determinando come appaiono a chi osserva
		4. Clip space:   proiezione dei vertici in un sistema omogeneo di coordinate, preparando per la fase successiva
		5. Normalized Device Coordinates: Divisione per W, normalizzando le coordinate in un range (-1.0, 1.0) per ogni asse
		6. Screen space: assegna i vertici alle coordinate dei pixel a schermo, dove l'oggetto è rasterizzata(Rendering pipeline) e visualizzato
	*/
}


void fragment() {
	// Called for every pixel the material is visible on.
	vec3 random_color_ws = hash33(floor(NODE_POSITION_WORLD)); // con questa funzione creo un vettore casuale che poi andrà a cambiare il colore in base all posizione
	vec3 albedo = texture(_MainTex, UV).rgb; // texure(sampler2D, UV coordinates: vec2) return ARGB vector
	albedo += random_color_ws * 0.15;
	ALBEDO = albedo; // ALBEDO: variabile d'ambiente di godot
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
