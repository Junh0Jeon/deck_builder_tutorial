class_name CardPile
extends Resource

signal card_pile_size_changed(cards_amount: int)

@export var card_array: Array[Card] = []


func is_empty() -> bool:
	return card_array.is_empty()


func darw_card() -> Card:
	var card = card_array.pop_front() # TODO: optimize
	card_pile_size_changed.emit(card_array.size())
	return card


func add_card(new_card: Card) -> void:
	card_array.append(new_card)
	card_pile_size_changed.emit(card_array.size())


func shuffle() -> void:
	card_array.shuffle()


func clear() -> void:
	card_array.clear()
	card_pile_size_changed.emit(card_array.size())


func _to_string() -> String:
	var _card_strings: PackedStringArray = []
	for i in range(card_array.size()):
		_card_strings.append("%s: %s" % [i+1, card_array[i].id])
	return "\n".join(_card_strings)
