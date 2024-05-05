class_name HealingPotion
extends Item

@export var effect : HealingEffect


func try_use(character: Character) -> bool:
	effect.apply_effect(character.get_all_stats(), character)
	return true
