#include "sym.h"

// for internal code ref
symrec *sym_table;


// LIST FUNCTIONS

/* The mfcalc code assumes that malloc and realloc
   always succeed, and that integer calculations
   never overflow.  Production-quality code should
   not make these assumptions.  */
#include <assert.h>
#include <stdlib.h> /* malloc, realloc. */
#include <string.h> /* strlen. */

#include <stdio.h>

symrec *putsym (char const *name, int sym_type)
{
	symrec *res = (symrec *) malloc (sizeof (symrec));
	res->name = strdup (name);
	res->type = sym_type;
	res->value.var = 0; /* Set value to 0 even if fun. */
	//printf("sym. value = %i\n", res->value.var);

	res->next = sym_table;
	sym_table = res;
	return res;
}

symrec *getsym (char const *name)
{
	for (symrec *p = sym_table; p; p = p->next)
		if (strcmp (p->name, name) == 0)
			return p;
	return NULL;
}

// int main()
// {
// 	init_table();
// 	printf("%p\n\n", getsym("sin"));
// 	// sym_table is always set to the latest entry
// 	for (symrec *p = sym_table; p; p = p->next)
// 		printf("%p   %s   %d\n", p, p->name, p->type);
// 	return 0;
// }