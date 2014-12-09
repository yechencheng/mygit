#!/usr/bin/ruby

for i in [4,6,8,12]
	for j in 0..4096
		if j.to_s(2).count("1") != i
			next
		end
		hexj = j.to_s(16)
		puts "#{i} #{hexj} : taskset #{hexj} parsecmgmt -a run -p fluidanimate -n #{i} -i native > #{i}_#{hexj}.log"
		if File.exist?("#{i}_#{hexj}.log")
			next
		end
		system("taskset #{hexj} parsecmgmt -a run -p fluidanimate -n #{i} -i native > #{i}_#{hexj}.log")
	end
end