#!/usr/bin/ruby

$str = File.open("parsec.blackscholes_32.log").readlines
#input data should be cleaned, and sorted in acseding order of time

$pre=0
$totalInst=0
Bound=1000000000

for i in 0..($str.length-1)
	#cache-misses,cache-references,cpu-clock,instructions,LLC-load-misses,LLC-store-misses
	entries = str[i].split
	if i != 0
		if (Bound-$totalInst).abs < ($totalInst + entries[3].to_i - Bound).abs
			#previous one is more closer
			data = AggregateData(i)
			$pre = i
			$totalInst = entries[3].to_i;
			puts data
		end
	end
end

data = AggregateData($str.length)
puts data


def AggregateData(upperbound)
	data = Array.new(6)
	for i in pre..(upperbound-1)
		entries = $str[i].split
		for j in 0..(entries.length-1)
			data[j] += entries[j].to_i
		end
	end
	return data
end