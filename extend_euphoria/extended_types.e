
-- extended_types.e

-- Showcase extended types: string

include struct.e

-- Strings, Char, and Byte:

global type String(sequence st)
    for i = 1 to length(st) do
	if not integer(st[i]) then
	    return 0
	end if
    end for
    return 1
end type
global constant String_rid = routine_id("String")
global type ListOfStrings(sequence s)
    return struct({{-2, String_rid}, s})
end type

global type Char(integer c)
    return c <= 127 and c >= -128
end type
global constant Char_rid = routine_id("Char")
global type ListOfChars(sequence s)
    return struct({{-2, Char_rid}, s})
end type

global type CharString(sequence st)
    for i = 1 to length(st) do
	if not Char(st[i]) then
	    return 0
	end if
    end for
    return 1
end type
global constant CharString_rid = routine_id("CharString")
global type ListOfCharStrings(sequence s)
    return struct({{-2, CharString_rid}, s})
end type

global type Byte(integer c)
    return c <= 255 and c >= 0
end type
global constant Byte_rid = routine_id("Byte")
global type ListOfBytes(sequence s)
    return struct({{-2, Byte_rid}, s})
end type

global type ByteString(sequence st)
    for i = 1 to length(st) do
	if not Byte(st[i]) then
	    return 0
	end if
    end for
    return 1
end type
global constant ByteString_rid = routine_id("ByteString")
global type ListOfByteStrings(sequence s)
    return struct({{-2, ByteString_rid}, s})
end type

-- List, Object, Double, Integer, Uinteger

global type List(sequence s)
    return 1
end type
global constant List_rid = routine_id("List")
global type ListOfLists(sequence s)
    return struct({{-2, List_rid}, s})
end type

global type Object(object x)
    return 1
end type
global constant Object_rid = routine_id("Object")
global type ListOfObjects(sequence s)
    return struct({{-2, Object_rid}, s})
end type

global type Double(atom f)
    return f
end type
global constant Double_rid = routine_id("Double")
global type ListOfDoubles(sequence s)
    return struct({{-2, Double_rid}, s})
end type

global type Integer(integer i)
    return i
end type
global constant Integer_rid = routine_id("Integer")
global type ListOfIntegers(sequence s)
    return struct({{-2, Integer_rid}, s})
end type

global type Uinteger(atom u)
    if floor(u) = u then
ifdef BITS64 then
	return u >= 0 and u <= #FFFFFFFFFFFFFFFF
elsedef
	return u >= 0 and u <= #FFFFFFFF
end ifdef
    end if
    return 0
end type
global constant Uinteger_rid = routine_id("Uinteger")
global type ListOfUintegers(sequence s)
    return struct({{-2, Uinteger_rid}, s})
end type


