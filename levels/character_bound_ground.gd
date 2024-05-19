extends StaticBody2D

@export var anchor_character: CharacterBody2D


# Workaround for issue https://github.com/godotengine/godot/issues/76917
func _physics_process(_delta: float) -> void:
	if anchor_character == null:
		push_warning("anchor_character is null")
		return
		
	self.position.x = anchor_character.position.x
