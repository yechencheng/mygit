#!/usr/bin/ruby

trace = File.open("A.txt").readlines
trace = trace.collect{|x| x.strip }

pre = Hash.new(trace.length)
prio = Array.new(trace.length)

pos = (trace.length-1)
for i in trace.reverse
	prio[pos] = pre[i] - pos
	pre[i] = pos
	pos = pos - 1
end

puts "Stack size : #{pre.length}"

stack = Array.new(pre.length, nil) #element for stack
pstack = Array.new(pre.length, 0) #priority for stack elements

pos = 0
while pos < trace.length
	#set current access to nil
	idx = stack.index trace[pos]
	if idx != nil
		stack[idx] = nil
	end

	curTop = trace[pos]
	curPrio = prio[pos]

	#promote current access to top of stack
	curTop, stack[0] = stack[0], curTop
	curPrio, pstack[0] = pstack[0], curPrio
	
	#processing insert
	j = 1
	while j < stack.length and curTop != nil
		if pstack[j] > curPrio or stack[j] == nil
			curTop, stack[j] = stack[j], curTop
			curPrio, pstack[j] = pstack[j], curPrio
		end
		j += 1
	end
	puts stack.join(",")
	pos += 1
end
