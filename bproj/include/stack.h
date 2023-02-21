#pragma once

// header file for the stack functions

typedef int T;
typedef struct stack stack;

stack* new_stack(void);

void push(stack *s, T x);
T pop(stack *s);
T peek(stack *s);
bool empty(stack *s);
void destroy(stack *s);
void compress(stack *s);



