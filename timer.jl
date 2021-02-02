function timer()
	println("")
	println("What time is it right now? (In 24 hours format.)")
	println("")
	println("Input the amount of hours") 
	hours_time_right_now = parse(Int,readline())
	if 0 > hours_time_right_now || hours_time_right_now ≥ 24 
		println("")
		println("Format not correct")
		return
	end
	println("")
	println("Input the amount of minutes") 
	minutes_time_right_now = parse(Int,readline())
	if 0 > minutes_time_right_now || minutes_time_right_now ≥ 60 
		println("")
		println("Format not correct") 
		return
	end
	println("")
	println("Input the amount of seconds")
	seconds_time_right_now = parse(Int,readline())
	if 0 > seconds_time_right_now || seconds_time_right_now ≥ 60
		println("")
		println("Format not correct")
		return
	end
	println("")
	println("#################################")
	println("")
	println("For how long you want your timer?") 
	println("")
	println("Input the amount of hours") 
	hour_for_timer = parse(Int,readline())
	println("")
	println("Input the amount of minutes") 
	minutes_for_timer = parse(Int,readline())
	println("")
	println("Input the amount of seconds")
	seconds_for_timer = parse(Int,readline())
	println("")
	println("#################################")
	println("")
	println("Right now it is:")
	println("$hours_time_right_now h : $minutes_time_right_now min : $seconds_time_right_now sec")
	println("")
	println("And you want an alarm in:")
	println("$hour_for_timer h : $minutes_for_timer min : $seconds_for_timer sec")
	if abs(seconds_for_timer) ≥ 60
		new_minutes_for_timer =  floor(seconds_for_timer/60)
		minutes_for_timer = Int(minutes_for_timer + new_minutes_for_timer)
		seconds_for_timer = seconds_for_timer % 60
	end
	if abs(minutes_for_timer) ≥ 60
		new_hours_for_timer =  floor(minutes_for_timer/60)
		hour_for_timer = Int(hour_for_timer + new_hours_for_timer)
		minutes_for_timer = minutes_for_timer % 60
	end
	if minutes_for_timer < 0
		minutes_for_timer = 60 + minutes_for_timer
		hour_for_timer = hour_for_timer + 1 
	end
	println("")
	println("#################################")
	println("")
	println("That means yo want to add")
	println("$hour_for_timer h : $minutes_for_timer min : $seconds_for_timer sec")
	println("")
	println("to")
	println("$hours_time_right_now h : $minutes_time_right_now min : $seconds_time_right_now sec")
	println("")
	println("#################################")
	final_seconds = seconds_time_right_now + seconds_for_timer
	final_minutes = minutes_time_right_now + minutes_for_timer
	final_hours = hours_time_right_now + hour_for_timer
	if abs(final_seconds) ≥ 60
		new_final_minutes = floor(final_seconds/60)
		new_final_minutes = Int(new_final_minutes + final_minutes)
		new_final_seconds = final_seconds % 60
	else	
	new_final_seconds = final_seconds
	new_final_minutes = final_minutes
	end
	if abs(new_final_minutes) ≥ 60
		new_final_hours = floor(new_final_minutes/60)
		new_final_hours = Int(new_final_hours + final_hours)
		new_final_minutes = new_final_minutes % 60
	else	
	new_final_minutes = final_minutes
	new_final_hours = final_hours
	end	
	println("")
	println("That sum of them is")
	println("$new_final_hours h : $new_final_minutes min : $new_final_seconds sec")
end
