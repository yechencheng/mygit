#!/usr/bin/ruby
#join two table of co-run and base
str1 = File.open("T5.txt").readlines
str2 = File.open("BaseBind.txt").readlines

for i in str1
	data1 = i.split(' ') #prog corunner case thread duration
	for j in str2
		data2 = j.split(' ') #prog thread duration
		if(data2[0] == data1[0] and (data1[3].to_i)*4+4 == (data2[1].to_i))
			puts data2[2]
		end
	end
end
