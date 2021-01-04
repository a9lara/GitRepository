# The following code was written by "julia for talented amateurs" (https://www.youtube.com/channel/UCQwQVlIkbalDzmMnr-0tRhw) 

begin
	an_letters = "aefhilmnorsxAEFHILMNORSX"
	print("\nI will cheer for you! Enter a word: ")
	word = readline()
	print("Enthusiasm level. Enter a number between 1 and 10: ")
	times = parse(Int64, readline())
	println()
	for i in word
    		shout = uppercase(i)
    		if i in an_letters
        		print("Give me an\t$i !"); sleep(1)
        		println("\t$shout !!!"); sleep(0.5)
    		else
        		print("Give me a\t$i !"); sleep(1)
        		println("\t$shout !!!"); sleep(0.5)
    		end
	end
	println("\nWhat does that spell?\n"); sleep(1)
	for j in 1:times
    		println(word, " !!!"); sleep(0.25)
	end
end

