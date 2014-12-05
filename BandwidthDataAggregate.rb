#!/usr/bin/ruby

$properties=[
	"instructions",
	"cache-misses",
	"cache-references",
	"stalled-cycles-frontend",
	"stalled-cycles-backend"
]

$pre=1
$totalInst=0
Bound=10000000000 #10^10

def AggregateData(upperbound)
	data = Array.new($properties.length+1, 0)
	if upperbound == 1
		return data
	end
	for i in $pre..(upperbound-1)
		entries = $str[i].split
		for j in 1..(entries.length-1)
			data[j] += entries[j].to_i
		end
	end

	#get duration
	data[0] = ($str[$pre > 1 ? $pre-1 : 1].split)[0]
	data[0] = ($str[upperbound-1].split)[0].to_f - data[0].to_f
	return data
end

InstID = $properties.index("instructions")

ARGV.each do|file|
	$pre = 1
	$totalInst = 0

	puts "Process #{file}  ==> aggregated_#{file}"
	$str = File.open("#{file}").readlines
	#input data should be cleaned, and sorted in acseding order of time, then event name
	output = File.open("aggregated_#{file}", "w")
	
	output.print "time"
	for i in $properties
		output.print "\t#{i}"
	end
	output.puts
	for i in 1..($str.length-1)
		#cache-misses,cache-references,cpu-clock,instructions,LLC-load-misses,LLC-store-misses
		entries = $str[i].split
		if i != 1
			if (Bound-$totalInst).abs < ($totalInst + entries[InstID+1].to_i - Bound).abs
				#previous one is more closer
				data = AggregateData(i)
				$pre = i
				$totalInst = entries[InstID+1].to_i
				output.puts data.join("\t")
			end
			$totalInst += entries[InstID+1].to_i;
		end
	end

	data = AggregateData($str.length)
	output.puts data.join("\t")
	output.close
end



