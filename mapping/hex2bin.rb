#!/usr/bin/ruby

#translate 16 base to 2 base
str = File.open("a.txt").readlines
out = File.open("b.txt", "w")

for i in str
	out.puts i.to_i(16).to_s(2).rjust(12,"0")
end
out.close