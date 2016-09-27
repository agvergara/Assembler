#Practica 4A
.data
	msgw: .ascii "Introduce un numero: "
	msge: .asciiz "El numero de Fibonacci corresponde con: "
	
.text
	
	la $a0, msgw
	li $v0, 4 # Load syscall print-string into $v0 
	syscall
	li $v0, 5
	syscall
	
	move $a0, $v0
	jal fibonacci
	
	move $t0, $v0
	
	la $a0, msge
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
fibonacci:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	sw $a0, 12($sp) 
	
	beq $a0, $zero, return0
	ble $a0, 2, return1
	
	subi $a0, $a0, 1 # Resto 1
	
	jal fibonacci #F(n-1)
	
	sw $v0, 8($sp)
	lw $a0, 12($sp)
	
	subi $a0, $a0, 2
	
	jal fibonacci # F(n-2)
	
	lw $t1, 8($sp)
	add $v0, $v0, $t1
	
exit:
	lw $ra, 20($sp)
	lw $fp, 12($sp)
	addiu $sp, $sp, 32
	jr $ra
		
return0:
	move $v0, $zero
	b exit
	
return1:
	li $v0, 1
	b exit

	
	
	
	
	
	
	
	
	
	
	