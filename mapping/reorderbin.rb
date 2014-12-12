#!/usr/bin/ruby

#reorder mapping to socket

input = File.open("a.txt").readlines
output = File.open("b.txt", "w")

for i in input
	x = "0"*12
	j = 0;
	while j < x.length
		x[j/2] = i[j]
		j += 2
	end
	j = 1
	while j < x.length
		x[j/2+6] = i[j]
		j += 2
	end
	output.puts "#{x[0..5]},#{x[6..11]}\t#{x[0..5].count("1")}"
end
output.close