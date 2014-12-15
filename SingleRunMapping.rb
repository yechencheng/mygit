#!/usr/bin/ruby

$programs=[     "parsec.blackscholes",
                "parsec.bodytrack",
                        "parsec.canneal",
                        "parsec.dedup",
                        "parsec.facesim",
                        "parsec.ferret",
                        #"parsec.fluidanimate",
                        "parsec.freqmine",
                        "parsec.netdedup",
                        "parsec.netferret",
                        "parsec.netstreamcluster",
                        "parsec.raytrace",
                        "parsec.streamcluster",
                        "parsec.swaptions",
                        "parsec.vips",
                        "parsec.x264"
]

r = Random.new
for p in $programs
	for i in [4,8]
		for j in 0..4096
			if j.to_s(2).count("1") != i
				next
			end
			hexj = j.to_s(16)
			puts "#{i} #{hexj} #{p} : taskset #{hexj} parsecmgmt -a run -p #{p} -n #{i} -i native > #{i}_#{hexj}_#{p}.log"
			if File.exist?("#{i}_#{hexj}_#{p}.log")
				next
			end
			system("taskset #{hexj} parsecmgmt -a run -p #{p} -n #{i} -i native > #{i}_#{hexj}_#{p}.log")

			#randomly rerun
			if(r.rand(1000) <= 2)
				for k in 0..9
					system("taskset #{hexj} parsecmgmt -a run -p #{p} -n #{i} -i native > verify_#{k}_#{i}_#{hexj}_#{p}.log")
				end
			end
		end
	end
end