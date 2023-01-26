// C program to evaluate a given
// expression where tokens are
// separated by space.

/*
	notes:
		u\makes heavy use of stacks
*/

#include <stdio.h>
#include <stdbool.h>

// globals
#include "common.h"

// Function to find precedence of operators.
int precedence(char op) {
	if(op == '+'||op == '-')
		return 1;
	if(op == '*'||op == '/')
		return 2;
	return 0;
}

// Function to perform arithmetic operations.
int applyOp(int a, int b, char op) {
	switch(op){
		case '+': return a + b;
		case '-': return a - b;
		case '*': return a * b;
		case '/': return a / b;
	}
}

bool isNumber(char c) {
	return ( c >= '0' && c <= '9' );
}

int evaluate(char* tokens)
{
	stack* values = new();
	stack* ops = new();
	
	for (; *tokens != '\0'; tokens++)
    {
        if (*tokens == ' ') 
		{
            continue;
		}

        if (*tokens == '(') 
		{
			push(ops, *tokens);
		} 
		else if (isNumber(*tokens)) 
		{
			int val = 0;
			while (*tokens != '\0' && isNumber(*tokens)) 
			{
				// interesting!!
				val = (val*10) + (*tokens-'0');
				tokens++;
			}
			push(values, val);
			tokens--; // correct extra increment
		}
		else if (*tokens == ')') 
		{
			while (!empty(ops) && peek(ops) != '(')
			{
				int val2 = pop(values);
				int val1 = pop(values);
				char op = pop(ops);
				// interesting
				push(values, applyOp(val1, val2, op));
			}

			if (!empty(ops))
			{
				pop(ops); // pop opening brace
			}
		}
		else // token is an operator
		{
			// checks if the precedence of the last pushed operator
			// is greater than the current token
			// if so, evaluates until that is not the case
			while(!empty(ops) && precedence(peek(ops)) >= precedence(*tokens))
			{
				int val2 = pop(values);
				int val1 = pop(values);
				char op = pop(ops);
				push(values, applyOp(val1, val2, op));
			}
			push(ops, *tokens);
		}
    }

	// apply remaining operators
	while (!empty(ops))
	{
		int val2 = pop(values);
		int val1 = pop(values);
		char op = pop(ops);
		push(values, applyOp(val1, val2, op));
	}
	return pop(values);
}

int main() {

	int n = evaluate("(23 + 16) * 3");
	printf("answer = %d\n", n);

	n = evaluate("3 + 4");
	printf("answer = %d\n", n);

	n = evaluate("(23 + 16) * 3");
	printf("answer = %d\n", n);

	return 0;
}


// This code is contributed by Nikhil jindal.
// thank you Nikhil