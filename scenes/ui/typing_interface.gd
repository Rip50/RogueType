extends CanvasLayer

@onready var text_input: LineEdit = %TextInput
@onready var displayed_text_label: RichTextLabel = %DisplayedTextLabel

signal correct
signal error
signal erase

#[color=green]capstan[/color] [color=red]c[/color]apstan ahoy treasure landlubber keelhaul avast ahoy avast 
#seadog wench swab scurvy avast buccaneer cutlass landlubber plank treasure cutlass doubloon cannon seadog scallywag yo-ho-ho maroon 
#booty yo-ho-ho matey privateer poop deck booty booty avast booty seadog doubloon grog buccaneer matey grog matey avast seadog 
#plank avast cutlass yo-ho-ho landlubber buccaneer privateer yo-ho-ho wench scurvy buccaneer avast grog seadog matey landlubber buccaneer capstan seadog cannon

var text := "capstan capstan ahoy treasure landlubber keelhaul avast ahoy avast seadog wench swab scurvy avast buccaneer cutlass landlubber plank treasure cutlass doubloon cannon seadog scallywag yo-ho-ho maroon booty yo-ho-ho matey privateer poop deck booty booty avast booty seadog doubloon grog buccaneer matey grog matey avast seadog plank avast cutlass yo-ho-ho landlubber buccaneer privateer yo-ho-ho wench scurvy buccaneer avast grog seadog matey landlubber buccaneer capstan seadog cannon"


func _ready() -> void:
	displayed_text_label.text = text
	text_input.text_changed.connect(_process_player_input)
	text_input.grab_focus()


func _process_player_input(input_text: String) -> void:
	var displayed_text := ""
	
	if input_text.length() == 0:
		displayed_text_label.text = text
	else:
		for i in text.length():
			if i >= input_text.length():
				displayed_text += text.substr(i)
				displayed_text_label.text = displayed_text
				break
				
			var inputed := input_text[i]
			var expected := text[i]
			
			match expected:
				inputed:
					displayed_text += "[color=green]%s[/color]"%expected
				" ":
					displayed_text += expected
				_:
					displayed_text += "[color=red]%s[/color]"%expected
					
		var last_char_idx = input_text.length() - 1
		if input_text[last_char_idx] == text[last_char_idx]:
			correct.emit()
		else:
			error.emit()
