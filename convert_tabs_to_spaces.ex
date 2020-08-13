
include std/io.e

constant cl = command_line()

with trace
trace(1)

sequence file

puts(1, "Usage: eui convert_tabs_to_spaces.ex FILE_TO_CONVERT.TXT\n\n")

printf(1, "Press any key to begin converting tabs to spaces in:\n%s\n\n", {cl[3]})
system("pause", 2)

file = read_file(cl[3])

integer n, num

n = 1
num = 0
while n <= length(file) do
	if file[n] = '\t' then
		file = file[1..n-1] & repeat(' ', 4) & file[n+1..$]
		num += 1
	end if
	n += 1
end while


if 1 = write_file(cl[3], file) then
	printf(1, "Successfully converted %d tabs into spaces in file:\n%s\n", {num, cl[3]})
else
	printf(1, "Error: Couldn't write to file:\n%s\n", {cl[3]})
end if

