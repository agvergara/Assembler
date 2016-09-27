#Atoi4 - Practica3G
.data
	strw: .asciiz "Escribe un numero: \n"
	string: .space 1024
	str_end: .asciiz "El resultado es: "
	str_desb: .asciiz "Se ha producido desbordamiento"
	
.text
	
main:
	#En el registro $t7 introduzco el equivalente en ASCII de \n
	li $t7, 10
	la $a0, strw
	li $v0, 4
	syscall
	li $v0 8
	la $a0, string
	li $a1, 1024
	syscall
	la $t0, string
	move $t9, $t0
	lb $t1, 0($t0)
	lb $t2, 0($t9)
   	beq $t2, $t7, finnish
   	subi $s0, $t1, 48
   	addi $t9, $t9, 1
   	
   	
 for:
 	addi $t9, $t9, 1
 	addi $t0, $t0, 1
 	lb $t2, 0($t9)
 	lb $t1, 0($t0)
 	#Si inserto solo un caracter, el siguiente será \n
 	beq $t1, $t7, finnish
 	#Hago la operacion num = num x 10
 	mult $s0, $t7
   	mflo $s0
   	#$t5 será el registro para comparar HI
   	#$t6 será el registro para comparar LO
   	move $t6, $s0
   	mfhi $t5
   	bnez $t5, finnish_desb
   	bltz $t6, finnish_desb
   	#Hago la operacion nextChar - '0'
   	subi $s1, $t1, 48
   	#Lo sumo a num
   	add $s0, $s0, $s1
   	bltz $s0, finnish_desb
   	#Repeat
   	bne $t2, $t7, for
   	beq $t2, $t7, finnish
   
finnish:
	la $a0, str_end
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
finnish_desb:
	la $a0, str_desb
	li $v0, 4
	syscall
	li $v0, 10
	syscall
