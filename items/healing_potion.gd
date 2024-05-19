class_name HealingPotion
extends Item

@export var effect : HealingEffect


func try_use(player: Player) -> bool:
	effect.apply_effect(player.get_all_stats(), player)
	return true
