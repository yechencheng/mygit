#!/usr/bin/ruby

str = File.open("parsec.blackscholes_32.log").readlines

$properties=[
	"instructions",
	"cache-misses",
	"cache-references",
	"cpu-clock",
	"LLC-load-misses",
	"LLC-store-misses"
]

$StartFlag=0
for i in str
	if $StartFlag == 0
		if i.start_with?("[PARSEC] Running")
			#Program Begin
			$StartFlag=1
		end
		next
	end
	if i.start_with?("[PARSEC] [----------    End of output    ----------]")
		#Program End
		break
	end

	entries = i.split #duration, count, event
	if not $properties.include?(entries[2])
		next
	end

	puts i
end