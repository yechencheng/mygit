#!/usr/bin/ruby

str = File.open("parsec.blackscholes_32.log").readlines
$i=0
$pre=0
$totalInst=0
Bound=1000000000
while $i < str.length
	#cache-misses,cache-references,cpu-clock,instructions,LLC-load-misses,LLC-store-misses

	$i += 6
end