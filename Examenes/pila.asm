#pila.asm Examen practicas 11 Diciembre 2014
.data
	msg: .asciiz "Introduce un numero: "
	eol: .asciiz "\n"
.text

	#the sentinel valie is 0 by default
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	move $a1, $zero
	jal create
	#$v0 and contains the address of the top of the stack
	move $s0, $v0
	move $a0, $s0
	jal pop
	
loop:	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beqz $v0, end_loop
	move $a1, $v0
	move $a0, $s0
	jal push
	move $s0, $v0
	move $a0, $s0
	jal pop
	b loop
	
push:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addu $fp, $sp, 32
	#$a0 contains value, $a1 contains pointer to last one
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	move $a0, $a1
	lw $a1, 0($fp)
	jal create
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
	
create:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addu $fp, $sp, 32
	#$a0 contains value, $a1 contains pointer to last one
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	#4 bytes for value and 4 for address
	li $a0, 8
	li $v0, 9
	syscall
	
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	sw $a0, 0($v0)
	sw $a1, 4($v0)
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addu $sp, $sp, 32
	jr $ra
	
pop:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 32
	
	sw $a0, 0($fp)
	lw $a0, 4($a0)
	
	beqz $a0, end_pop
	
	jal pop
	
end_pop:
	lw $a0, 0($fp)
	lw $a0, 0($a0)
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, eol
	syscall	
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra

end_loop:
	li $v0, 10
	syscall
	

	
	
