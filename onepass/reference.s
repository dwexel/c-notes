.global main
main:
  push $4
  push $2
  push $10
  pop %rax
  pop %rbx
  mul %rbx
  push %rax
  pop %rax
  pop %rbx
  add %rbx, %rax
  push %rax
  push $3
  push $5
  push $1
  pop %rax
  pop %rbx
  add %rbx, %rax
  push %rax
  pop %rax
  pop %rbx
  mul %rbx
  push %rax
  pop %rax
  pop %rbx
  add %rbx, %rax
  push %rax
  pop %rax
  ret
