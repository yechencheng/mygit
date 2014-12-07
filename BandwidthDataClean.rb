#!/usr/bin/ruby

ARGV.each do |file|
	puts "Processing #{file} ==> cleaned_#{file}"
	str = File.open(file).readlines
	output = File.open("cleaned_#{file}", "w")
	$properties=[	#not ordered
		"instructions",
		"cache-misses",
		"cache-references",
		"stalled-cycles-frontend",
		"stalled-cycles-backend"
	]

	$StartFlag=0
	for i in str
		i = i.gsub(/\(msec\)/, '')	#clean (mesc)
		i = i.gsub(/,/, '')
		if $StartFlag == 0
			if i.start_with?("[PARSEC] [---------- Beginning of output ----------]")
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

		j = 2
		while j < entries.length
			if $properties.include?(entries[j])
				break
			end
			j += 1
		end

		if j >= entries.length
			next
		end

		if entries[j-1] == "counted>"
			entries = entries.drop(j-3)
		else
			entries = entries.drop(j-2)
		end
		output.puts entries.join("\t")
	end
	output.close
end