
with trace
trace(1)

integer d = 4

sequence data
data = repeat(0,d)
for i = 1 to length(data) do
	data[i] = repeat(0,d)
	for j = 1 to length(data[i]) do
		data[i][j] = repeat(0,d)
		for k = 1 to length(data[i][j]) do
			data[i][j][k] = j * i * k
		end for
	end for
end for

? data


type eubyte(integer i)
	return 1 <= i and i <= 256
end type

function bad_to_good(eubyte i)
	return 256 - i + 1
end function

function recursive_bad_to_good(object s)
	object tmp
	integer j
	if atom(s) then
		return bad_to_good(s)
	end if
	j = length(s)
	for i = 1 to length(s) / 2 do
		tmp = recursive_bad_to_good(s[i])
		s[i] = recursive_bad_to_good(s[j])
		s[j] = tmp
		--s[i] = recursive_bad_to_good(s[i])
		j -= 1
	end for
	return s
end function

function recursive_mirror_image(object s)
	object tmp
	integer j
	if atom(s) then
		return s
	end if
	j = (length(s) / 2) + 1
	for i = length(s) / 2 to 1 by -1 do
		tmp = recursive_bad_to_good(s[i])
		s[i] = recursive_bad_to_good(s[j])
		s[j] = tmp
		--s[i] = recursive_bad_to_good(s[i])
		j += 1
	end for
	return s
end function

? recursive_mirror_image(data)


