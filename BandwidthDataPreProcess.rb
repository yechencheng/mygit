#!/usr/bin/ruby

#input : (time, count, event)
#output : (time, count1, count2, count3)
#data clean == synthesis. if count is <not counted>, use
#previous datum fill it

$properties=[	#order sensitive
	"instructions",
	"cache-misses",
	"cache-references",
	"stalled-cycles-frontend",
	"stalled-cycles-backend"
]

ARGV.each do|file|
	puts "Processing #{file} ==> preprocessed_#{file}"
	str = File.open("#{file}").readlines
	output = File.open("preprocessed_#{file}", "w")
	
	output.print "time"
	for i in $properties
		output.print "\t#{i}"
	end
	output.puts 

	entries = Array.new($properties.length+1); # time, properties

	flag = 0
	for i in str
		entry = i.split
		if entry.length == 3
			id = $properties.index(entry[2])
			entries[id+1] = entry[1]
		end

		if(entries[0] != entry[0] and flag != 0)
			puts "#{file} #{entries[0]}\t#{entry[0]}"
			break
		end
		entries[0] = entry[0]

		flag += 1
		if flag == $properties.length
			flag = 0
			output.puts entries.join("\t")
		end
	end
	output.close
end