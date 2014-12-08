#!/usr/bin/ruby

for i in [4,6,8,12]
	for j in 0..4096
		if j.to_s(2).count("1") != i
			next
		end
		system("taskset #{j} parsecmgmt -a run -p fluidanimate -n #{i} -i native > #{i}_#{j}.log")
	end
end