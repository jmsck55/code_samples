
-- NOTE:
-- with type_check (default), Euphoria treats all variables as objects
-- (and does no type checking) and doesn't call types,
-- unless called directly as a function such as: 'if atom(a) then'

-- Uncomment this line when done debugging to gain speed
--without type_check

-- Comment out these lines (trace statements) when done debugging to gain speed
with trace
trace(1)

include extended_types.e

-- main:

type int(integer i)
    return 1
end type
constant int_rid = routine_id("int")

sequence datatype

struct data

datatype = {int_rid,{-3, int_rid, 2}}

data = {datatype, {1, {2, 3}}}

? data[2]


struct_ids = {datatype}
struct_id mydata

mydata = {1, {1, {2, 3}}}

? mydata[2]



