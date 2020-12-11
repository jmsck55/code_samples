-- Copyright (c) 2020 James J. Cook

-- remove_action.ex

-- Description:
-- Fastest code to search and replace bytes, inside files, of specified file extension(s), in a directory.

include std/io.e
include std/filesys.e

-- with trace
-- trace(1)

-- NOTE: You can edit existing directory and file_extensions:

constant directory = "html" -- in current directory, html directory
constant file_extensions = {"html"} -- "*.html"

constant search_and_replace =
-- list of {search text, followed by replace text}:
{
	-- {"SAMPLE_SEARCH", "SAMPLE_REPACE"},
	{"</div>","</DIV>"},
	{"</DIV>","</div>"},
	{" action=\"javascript:void(0)\"", ""}
}

-- NOTE: You can add more items to the list, above.

sequence search = search_and_replace

integer len = length(search_and_replace)
sequence first = repeat(0, len)
for i = 1 to len do
	first[i] = search[i][1][1]
	search[i][1] = search[i][1][2..$]
end for

integer numberOfFilesScanned = 0
integer numberOfFilesFound = 0

sequence file_buffer
sequence word_buffer

procedure set_file_buffer()
	file_buffer = {}
end procedure

procedure save_to_file_buffer(sequence str)
	file_buffer = file_buffer & str
end procedure

procedure append_to_file_buffer(integer ch)
	file_buffer = append(file_buffer, ch)
end procedure

procedure set_word_buffer()
	word_buffer = {}
end procedure

function mygetc(integer fn)
	integer ch
	if length(word_buffer) then
		ch = word_buffer[1]
		word_buffer = word_buffer[2..$]
		return ch
	end if
	return getc(fn)
end function

procedure ungetc(object ch)
	word_buffer = word_buffer & ch
end procedure

function replace_function(sequence path_name, sequence item)
-- this function accepts two sequences as arguments
	if find('d', item[D_ATTRIBUTES]) then
		return 0 -- Ignore directories
	end if
	if not find(fileext(item[D_NAME]), file_extensions) then
		return 0 -- ignore any other file extension
	end if
	sequence filename = path_name & {SLASH} & item[D_NAME]
	sequence tmp, st
	integer found, next, count
	integer fn, ch, c, flag
	set_file_buffer()
	set_word_buffer()
	count = 0
	fn = open(filename, "rb")
	if fn = -1 then
		return 0 -- keep going
	end if
	ch = getc(fn)
	while ch != EOF do
		flag = 0
		next = 1
		while 1 do
			found = find(ch, first, next)
			if not found then
				exit
			end if
			next = found + 1
			st = search[found][1]
			len = length(st)
			tmp = {}
			flag = 1
			for i = 1 to len do
				c = mygetc(fn)
				tmp = append(tmp, c)
				if c != st[i] then
					flag = 0
					exit
				end if
			end for
			if flag then
				count += 1
				save_to_file_buffer(search[found][2])
				exit
			else
				ungetc(tmp)
			end if
		end while
		if flag = 0 then
			append_to_file_buffer(ch)
		end if
		ch = mygetc(fn)
	end while
	close(fn)
	if count then
ifdef WINDOWS then
		system("move /Y " & filename & " " & item[D_NAME] & ".bak > nul", 2)
elsifdef UNIX then
		system("mv -f " & filename & " " & item[D_NAME] & ".bak", 2)
end ifdef
		fn = open(filename, "wb")
		if fn = -1 then
			return 0 -- keep going
		end if
		puts(fn, file_buffer)
		close(fn)
	end if
	
-- old code:
-- 	sequence data = read_file(filename)
-- 	count = 0
-- 	for i = 1 to len do
-- 		search_text = search_and_replace[i][1]
-- 		replace_text = search_and_replace[i][2]
-- 		next = 1
-- 		while 1 do
-- 			found = match(search_text, data, next)
-- 			if not found then
-- 				exit
-- 			end if
-- 			count += 1
-- 			next = found + length(search_text)
-- 			data = data[1..found-1] & replace_text & data[next..$]
-- 			write_file(filename, data)
-- 		end while
-- 	end for
	
	if count then
		printf(STDOUT, "%s: %d\n", {filename, count})
		numberOfFilesFound += 1
	end if
	numberOfFilesScanned += 1
	
	return 0 -- keep going
end function

integer replace_function_id = routine_id("replace_function")

puts(STDOUT, "Global Phrase Replace Program\n")
puts(STDOUT, "REPLACE [number] \'THIS\' WITH => \'THAT\' VARIABLES:\n")
puts(STDOUT, "Begin List:\n")
for i = 1 to length(search_and_replace) do
	printf(STDOUT, "\t[%d] ", {i})
	printf(STDOUT, "\'%s\' => \'%s\'\n", search_and_replace[i])
end for
puts(STDOUT, "End List.\n")
puts(STDOUT, "READY TO REPLACE? ")
puts(STDOUT, "File extensions:\n")
for i = 1 to length(file_extensions) do
	printf(STDOUT, "\t*.%s\n", {file_extensions[i]})
end for
printf(STDOUT, " from directory: \"%s\"\n", {directory})
ifdef WINDOWS then
system("pause", 2)
elsedef
puts(STDOUT, "Press Enter to continue.\n")
getc(0)
end ifdef

-- trace(1)
object exit_code = walk_dir(directory, replace_function_id)

puts(STDOUT, "done.\n")
printf(STDOUT, "Number of Files Scanned: %d, Number of Files Found: %d\n", {numberOfFilesScanned, numberOfFilesFound})
ifdef WINDOWS then
system("pause", 2)
elsedef
puts(STDOUT, "Press Enter to continue.\n")
getc(0)
end ifdef

