#!/usr/bin/ruby

$properties=[
		"cache-misses",
		"cache-references",
		"cpu-clock",
		"instructions",
		"LLC-load-misses",
		"LLC-store-misses"
]

$pre=1
$totalInst=0
Bound=1000000000 #10^9

def AggregateData(upperbound)
	data = Array.new(7, 0)
	for i in $pre..(upperbound-1)
		entries = $str[i].split
		data[0] = entries[0]
		for j in 1..(entries.length-1)
			data[j] += entries[j].to_i
		end
	end
	return data
end

ARGV.each do|file|
	$pre = 1
	$totalInst = 0

	puts "Process #{file}  ==> aggregated_#{file}"
	$str = File.open("#{file}").readlines
	#input data should be cleaned, and sorted in acseding order of time, then event name
	output = File.open("aggregated_#{file}", "w")
	

	for i in 1..($str.length-1)
		#cache-misses,cache-references,cpu-clock,instructions,LLC-load-misses,LLC-store-misses
		entries = $str[i].split
		if i != 1
			if (Bound-$totalInst).abs < ($totalInst + entries[4].to_i - Bound).abs
				#previous one is more closer
				data = AggregateData(i)
				$pre = i
				output.puts data.join("\t")
			end
			$totalInst += entries[4].to_i;
		end
	end

	data = AggregateData($str.length)
	output.puts data.join("\t")
	output.close
end



