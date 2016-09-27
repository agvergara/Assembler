#pila.asm Examen practicas 11 Diciembre 2014
	#PUT THE DAMN FRAME POINTER TO THE TOP
		#PUT THE DAMN FRAME POINTER TO THE TOP
			#PUT THE DAMN FRAME POINTER TO THE TOP
				#PUT THE DAMN FRAME POINTER TO THE TOP
					#PUT THE DAMN FRAME POINTER TO THE TOP
						#PUT THE DAMN FRAME POINTER TO THE TOP
.data
	msg: .asciiz "Introduce un numero: "
	eol: .asciiz "\n"
.text
	#Sentinel value is now -1
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	move $a1, $zero
	jal create
	#This jal returns the pointer to the top of the stack
	#So we move it to $s0
	move $s0, $v0

loop:
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, -1, end_loop
	#$v0 has the address of the memory
	move $a0, $v0
	move $a1, $s0
	jal push
	move $s0, $v0
	b loop
	
end_loop:
	#This is the top!
	move $a0, $s0
	#And now is on the first!
	jal pop
	li $v0, 10
	syscall
	
	
push:subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	jal create
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra	
	
create:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addu $fp, $sp, 28
	#Save the value a0 and the address a1
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	#8 bytes: 4 for the value and 4 for the address
	li $a0, 8
	li $v0, 9
	syscall

	lw $a0, 0($fp)
	lw $a1, -4($fp)
	#Now that $v0 has the address of the reserved memory, we can store $a0 there
	
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
	addiu $fp, $sp, 28
	#Store the address... Just in case
	
	sw $a0, 0($fp)
	#Load address to previous
	lw $a0, 4($a0)

	beqz $a0, print_pop

	jal pop
	
print_pop:
	#Load the address from 0($fp) and load again from 0($a0) the value
	lw $a0, 0($fp)
	lw $a0, 0($a0)
	li $v0, 1
	syscall
	
	la $a0, eol
	li $v0, 4
	syscall
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
	
	
