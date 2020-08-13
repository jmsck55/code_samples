
-- Certain functions use file numbers (fn). They may be considered as "streams".
-- Like all streams, they need to be opened and closed.
-- Functions include: open, close, printf, getc
-- 
-- With file numbers, (fn),
-- zero (0) is standard in (stdin)
-- one (1) is standard out (stdout)
-- two (2) is standard error (stderr)
-- three or greater (fn >= 3) valid file number
-- less than zero (fn < 0) or negative one (fn = -1) bad file number
-- All valid file numbers must be "closed"--after you are done using them,
--  sooner the better, to conserve (or use less) system resources,
--  this will make response times better, as the system uses less resources.
-- Especially memory needs to be freed once you are done using it,
--  as soon as possible, so that other memory can be close to the processor (fastest).
-- Files use memory when they are loaded into main memory.
-- Pick small bits of memory to use close to the processor. (L2 cache, L1 cache)
-- Do everything you need to do with them before swapping that memory back to 
--  main memory.
-- This will lead to better programming, in any programming language.

-- In "The Euphoria progrmaming language", 
-- on a "read-only" file, this happens:

integer fn

-- Open readonly file for writing:
fn = open("readonly.txt", "w")
? fn -- displays (-1)
if (fn = -1) then
	puts(1, "Unable to open file for writing\n")
	--abort(1) -- there are more lines to execute following this statement
end if
if (fn > 0) then
	close(fn)
end if

-- Open readonly file for reading:
fn = open("readonly.txt", "r")
? fn -- displays (3 or higher, depends on how many files were opened)
if (fn = -1) then
	puts(1, "Unable to open file for reading\n")
	abort(1) -- return error level 1
end if
if (fn > 0) then
	close(fn)
end if

abort(0) -- return error level 0
