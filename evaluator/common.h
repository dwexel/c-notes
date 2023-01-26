#pragma once

typedef int T;
// The type of the stack elements.

typedef struct {
    T *bottom;
    T *top;
    T *allocated_top;
} stack;

// why squiggles?
stack* new(void);
void destroy(stack *s);
bool empty(stack *s);
void push(stack *s, T x);

T pop(stack *s);
T peek(stack *s);

void compress(stack *s);



