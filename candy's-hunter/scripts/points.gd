extends RichTextLabel

var max_width := 500.0

func _init() -> void:
	text = "Pontos: " + str(Global.points)

func _ready():
	size = Vector2.ZERO
	fit_content = true
	finished.connect(_fit_width, CONNECT_DEFERRED)
	global_position.x = get_viewport_rect().position.x + get_viewport_rect().size.x - size.x

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	text = "Pontos: " + str(Global.points)

func _fit_width() -> void:
	# block the signals so "finished" does not trigger this function again
	set_block_signals(true)
	var original_autowrap = autowrap_mode
	# save the position
	var tmp = global_position
	# move it out of the way to avoid flashing
	#global_position.x = -100000 THIS THING WAS FLASHING... YOU BECAME WHAT YOU HAD TO DESTROY!!
	# disable autowrap
	autowrap_mode = TextServer.AUTOWRAP_OFF
	# make it 0, 0
	size = Vector2.ZERO
	# wait one frame
	await get_tree().process_frame
	# now we have the size with no autowrap
	# if the width is bigger than max width clamp it
	var w = clampf(size.x, 0, max_width)
	var h = size.y
	# restore the autowrap mode
	autowrap_mode = original_autowrap
	# set the maximum size we got
	size.x = w
	# wait one frame for the text to resize
	await get_tree().process_frame
	# if the height is bigger than before we have multiple lines
	# and we may need to make the width smaller
	if size.y > h:
		# save the height
		h = size.y
		# keep lowering the width until the height changes
		while true:
			# lower the width a bit
			size.x -= 10
			# wait one frame
			await get_tree().process_frame
			# check if the height changed
			if not is_equal_approx(size.y, h):
				# if it changed we made the textbox too small
				# restore the width and break the while loop
				size.x += 10
				break
	# wait one frame
	await get_tree().process_frame
	# restore the height
	size.y = h
	# restore the original position
	global_position = tmp
	# unblock the signals
	set_block_signals(false)
	
	global_position.x = get_viewport_rect().position.x + get_viewport_rect().size.x - size.x
