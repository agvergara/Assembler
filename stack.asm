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
	move $a1, $a0
	jal create
	#This jal returns the pointer to the top of the stack
	#So we move it to $s0
	move $s0, $v0
	move $s1, $v0
	move $s2, $v0

loop:
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, -1, end_loop
	#$v0 has the address of the memory
	move $a0, $s0
	move $a1, $v0
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
	addu $fp, $sp, 28
	
	sw $a0, 0($fp)
	
	li $a0, 4
	li $v0, 9
	syscall
	#Just to have the count of the numbers
	#addi $s1, $s1, 4
	lw $a0, 0($fp)
	#Now that $v0 has the address of the reserved memory, we can store $a0 there
	
	sw $a0, 0($v0)
	
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
	lw $a0, 0($s1)

	beqz $a0, print_pop
	addi $s1, $s1, 4
	jal pop
	
print_pop:
	lw $a0, 0($s2)
	beqz $a0, finnish
	addi $s2, $s2, 4
	li $v0, 1
	syscall
	
	la $a0, eol
	li $v0, 4
	syscall
	
finnish:lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
