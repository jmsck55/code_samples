-- Copyright (c) 2020 James J. Cook

-- struct.e

-- Showcase types and struct

global type struct(sequence s)
    object a, b
    integer option
    if length(s) = 2 then
	if integer(s[1]) then
	    return call_func(s[1], {s[2]})
	end if
	if length(s[1]) = length(s[2]) then
	    for i = 1 to length(s[1]) do
		a = s[1][i]
		if sequence(a) then
		    b = a[1]
		    if integer(b) then
			option = b
		    else
			return 0
		    end if
		    if option = -2 or option = -3 then
			b = s[2][i]
			if option = -2 then
			    if length(a) != 2 then
				return 0
			    end if
			elsif option = -3 then
			    if length(a) != 3 or not integer(a[3]) or length(b) != a[3] then
				return 0
			    end if
			end if
			for j = 1 to length(b) do
			    if not struct({a[2], b[j]}) then
				return 0
			    end if
			end for
			return 1
		    end if
		end if
		if not struct({s[1][i], s[2][i]}) then
		    return 0
		end if
	    end for
	    return 1
	end if
    end if
    return 0
end type

global sequence struct_ids
struct_ids = {}

global type struct_id(sequence s)
    if length(s) = 2 then
	if integer(s[1]) then
	    return struct({struct_ids[s[1]], s[2]})
	end if
    end if
    return 0
end type

global function register_struct_id(sequence s)
    integer f
    f = find(s, struct_ids)
    if f then
	return f
    end if
    struct_ids = append(struct_ids, s)
    return length(struct_ids)
end function


