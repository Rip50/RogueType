class_name Coin
extends Item


func try_use(player: Player) -> bool:
	var inventory = player.inventory
	inventory.add_gold(1)
	return true
