// appendtocontainer.h
// Copyright (c) 2021 James Cook


#ifndef __APPENDTOCONTAINER_H__
#define __APPENDTOCONTAINER_H__


#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>


#define CHUNK 100

typedef struct {
	size_t length;
	void** ptr;
} appendcontainer;

void appendtocontainer(appendcontainer* s, void* x)
{
	size_t remainderIs = s->length % CHUNK;
	if (!remainderIs)
	{
		appendcontainer newtmp;
		newtmp.length = s->length + CHUNK;
		newtmp.ptr = calloc(newtmp.length, sizeof(void*));
		if (newtmp.ptr == NULL)
		{
			fputs("Memory error", stderr);
			exit(2);
		}
		if (s->ptr)
		{
			memcpy(newtmp.ptr, s->ptr, s->length * sizeof(void*));
			free(s->ptr);
		}
		*s = newtmp;
	}
	s->ptr[s->length++] = x;
}

char* getLine(FILE* stream)
{
	// returns NULL at end of file.
	char buf[CHUNK];
	char* tmp, * line = NULL;
	size_t len, size = 0, maxchars = CHUNK - 1;
	do
	{
		if (!fgets(buf, CHUNK, stream))
		{
			break;
		}
		len = strlen(buf);
		tmp = (char*)malloc(len + size + 1);
		if (tmp == NULL)
		{
			fputs("Memory error", stderr);
			exit(2);
		}
		if (line)
		{
			memcpy(tmp, line, size + 1);
			free(line);
		}
		line = tmp;
		memcpy(line + size, buf, len + 1);
		size += len;
	} while (len == maxchars);
	return line;
}

appendcontainer * readlines(const char * filename)
{
	FILE * pFile;
	char * line;
	appendcontainer* lines;
	pFile = fopen ( filename , "r" );
	if (pFile == NULL)
	{
		fputs("File error", stderr);
		exit(1);
	}
	lines = (appendcontainer*)malloc(sizeof(appendcontainer));
	if (lines == NULL)
	{
		fputs("Memory error", stderr);
		exit(2);
	}
	lines->length = 0;
	lines->ptr = NULL;
	line = getLine(pFile);
	while (line)
	{
		appendtocontainer(lines, line);
		line = getLine(pFile);
	}
	/* the whole file is now loaded in the memory buffer. */
	fclose (pFile);
	return lines;
}

#endif // !__APPENDTOCONTAINER_H__
