#include <stdlib.h>
#include <stdio.h>

// shortcut macro
#define AST_NEW(tag, ...) \
  ast_new((AST){tag, {.tag=(struct tag){__VA_ARGS__}}})

typedef struct AST AST; // Forward reference
struct AST {
	enum {
		AST_NUMBER,
		AST_ADD,
		AST_MUL,
	} tag;
	union {
		struct AST_NUMBER { int number; } AST_NUMBER;
		struct AST_ADD { AST *left; AST *right; } AST_ADD;
		struct AST_MUL { AST *left; AST *right; } AST_MUL;
	} data;
};

void ast_print(AST *ptr);
AST *ast_new(AST ast);


int main()
{
	// define an abstract syntax tree
	AST *term = 
	AST_NEW(AST_ADD,
		AST_NEW(AST_NUMBER, 4),
		AST_NEW(AST_ADD,
			AST_NEW(AST_MUL, 
				AST_NEW(AST_NUMBER, 2), 
				AST_NEW(AST_NUMBER, 10),
			),
			AST_NEW(AST_MUL,
				AST_NEW(AST_NUMBER, 3),
				AST_NEW(AST_ADD,
					AST_NEW(AST_NUMBER, 5),
					AST_NEW(AST_NUMBER, 1),
				),
			),
		),
	);
	
	ast_print(term);

	return 0;
}

// returns ast pointer
// declaration does not allocate mem.
AST *ast_new(AST ast) {
	AST *ptr = malloc(sizeof(AST));
	if (ptr) *ptr = ast;
	return ptr;
}

// prints pretty
void ast_print(AST *ptr) {
  AST ast = *ptr;
  switch (ast.tag) {
    case AST_NUMBER: {
      struct AST_NUMBER data = ast.data.AST_NUMBER;
      printf("%d", data.number);
      return;
    }
    case AST_ADD: {
      struct AST_ADD data = ast.data.AST_ADD;
      printf("(");
      ast_print(data.left);
      printf(" + ");
      ast_print(data.right);
      printf(")");
      return;
    }
    case AST_MUL: {
      struct AST_MUL data = ast.data.AST_MUL;
      printf("(");
      ast_print(data.left);
      printf(" * ");
      ast_print(data.right);
      printf(")");
      return;
    }
  }
}