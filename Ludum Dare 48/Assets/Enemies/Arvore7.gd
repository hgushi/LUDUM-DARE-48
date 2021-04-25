extends Arvore

var bomerangue = load("res://Assets/Enemies/7.tscn")
func _on_AtaqueTimer_timeout():
	var projetil = bomerangue.instance()
	projetil.alvo = player_alvo
	self.add_child(projetil)
