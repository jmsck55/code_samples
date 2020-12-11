-- Copyright (c) 2020 James J. Cook

with trace

procedure recursive_walk(object x)
	if atom(x) then
		printf(1,"%g", x)
		return
	elsif length(x) = 0 then
		puts(1,"{}")
		return
	end if
	puts(1,"{")
	recursive_walk(x[1])
	for i = 2 to length(x) do
		puts(1,",")
		recursive_walk(x[i])
	end for
	puts(1,"}")
end procedure

function while_loop_walk(object x)
-- works, you just can't use 0, treat it like NULL, or use another value
	sequence p, s
	object ob
	if atom(x) then
		s = sprintf("%g", x)
		return s
	end if
	s = "{"
	p = {x}
	while length(p) do
		if atom(p[1]) then
			s[$] = '}'
			s = s & ","
			p = p[2..$]
		elsif length(p[1]) = 0 then
			p = p[2..$]
		else
			ob = p[1][1]
			p[1] = p[1][2..$]
			if atom(ob) then
				s = s & sprintf("%g,", ob)
			elsif length(ob) = 0 then
				s = s & "{},"
			else
				s = s & "{"
				p = {ob} & {-1} & p
			end if
		end if
	end while
	s[$] = '}'
	return s
end function

object a

a = {1,{2,1,2,{}},{{3,4},5},6}

print(1, a)
puts(1,"\n")

trace(1)

recursive_walk(a)
puts(1,"\n")

puts(1, while_loop_walk(a))
puts(1,"\n")


