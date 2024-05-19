class_name DropData 
extends Resource

enum RandType { STANDARD, NORMAL}

@export var item : PackedScene
@export_range( 0, 100, 1, "suffix:%" ) var probability : float = 100
@export var count_randomization_type : RandType = RandType.STANDARD
@export_range( 1, 10, 1, "suffix:items" ) var min_amount : int = 1
@export_range( 1, 10, 1, "suffix:items" ) var max_amount : int = 1
@export var mean_amount: int = 1
@export var amount_deviation: int = 1


func get_drop_count() -> int:
	var count := 0
	
	if randf_range( 0, 100 ) >= 100 - probability:
		match count_randomization_type:
			RandType.NORMAL:
				count = floori(randfn(mean_amount, amount_deviation))
			RandType.STANDARD:
				count = randi_range( min_amount, max_amount)
	
	return max(0, count)
