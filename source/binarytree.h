// binarytree.h
// Copyright (c) 2021 James Cook


#ifndef __BINARYTREE_H__
#define __BINARYTREE_H__

#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>

// ordered binary tree, and convert a binary tree into a doubly-linked list.
// See also: http://cslibrary.stanford.edu/109/TreeListRecursion.html

typedef struct node3 {
	void* ptr; // data
	size_t count;
	struct node* small;
	struct node* large;
} binarytree, linkedlist;

typedef int comparefunction(void*, void*); // return 0 if equal, 1 if A > B, -1 if A < B.

binarytree* lookup(comparefunction* func, binarytree* node, void* target)
{
	// return NULL, or the node containing the target data pointer.
	if (node == NULL)
	{
		return NULL; // target not found in binary search tree.
	}
	else
	{
		int value = func(target, node->ptr);
		if (value == 0)
		{
			return node; // target found, return node that it was found in.
		}
		else if (value == -1)
		{
			return lookup(func, node->small, target);
		}
		else if (value == 1)
		{
			return lookup(func, node->large, target);
		}
		else
		{
			// Error, ToDo: Handle error.
		}
	}
}

binarytree* NewBinaryTree(void* data, size_t count)
{
	// count is usually 1.
	binarytree* node = (binarytree*)malloc(sizeof(binarytree));
	if (node == NULL)
	{
		fprintf("Memory error", stderr);
		exit(2);
	}
	node->ptr = data;
	node->count = count;
	node->small = NULL;
	node->large = NULL;
	return node;
}

binarytree* insert(comparefunction* func, binarytree* node, void* target)
{
	if (node == NULL)
	{
		return NewBinaryTree(target, 1);
	}
	else
	{
		int value = func(target, node->ptr);
		if (value == 0)
		{
			node->count++; // store identical entries as one node. (disable by returning 1 or -1 instead of 0 from the compare function.)
		}
		else if (value == -1)
		{
			node->small = insert(func, node->small, target);
		}
		else if (value == 1)
		{
			node->large = insert(func, node->large, target);
		}
		else
		{
			// Error, ToDo: Handle error.
		}
		return node; // return the (unchanged) node pointer
	}
}

// Tree to doubly-linked List:

// helper function -- given two list nodes, join them
// together so the second immediately follow the first.
// Sets the .next of the first and the .previous of the second.
//
void join(linkedlist* a, linkedlist* b)
{
	a->large = b;
	b->small = a;
}


// helper function -- given two circular doubly linked
// lists, append them and return the new list.
//
linkedlist* append(linkedlist* a, linkedlist* b)
{
	linkedlist* aLast, * bLast;

	if (a == NULL) return b;
	if (b == NULL) return a;

	aLast = a->small;
	bLast = b->small;

	join(aLast, b);
	join(bLast, a);

	return a;
}


// --Recursion--
// Given an ordered binary tree, recursively change it into
// a circular doubly linked list which is returned.
//
linkedlist* treeToList(binarytree* root)
{
	linkedlist* aList, * bList;

	if (root == NULL) return NULL;

	/* recursively solve subtrees -- leap of faith! */
	aList = treeToList(root->small);
	bList = treeToList(root->large);

	/* Make a length-1 list ouf of the root */
	root->small = root;
	root->large = root;

	/* Append everything together in sorted order */
	aList = append(aList, (linkedlist*)root);
	aList = append(aList, bList);

	return aList;
}


#endif // !__BINARYTREE_H__
