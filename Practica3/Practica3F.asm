#Atoi3 -> Practica 3F
.data
	strw: .asciiz "Escribe un numero: \n"
	string: .space 1024
	str_end: .asciiz "El resultado es: "
	
.text
	
main:
	#En el registro $t7 introduzco el equivalente en ASCII de \n
	#En el registro $t6 introduzco el numero que sea mayor de 57 (9) no interesa
	#En el registro $t5 introduzco el numero que sea mayor de 48 (0) no interesa
	li $t7, 10
	li $t6, 57
	li $t5, 48
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
	ble $t1, $t5, finnish
 	bge $t1, $t6, finnish
   	
 for:
 	addi $t9, $t9, 1
 	addi $t0, $t0, 1
 	lb $t2, 0($t9)
 	lb $t1, 0($t0)
 	blt $t1, $t5, finnish
 	bgt $t1, $t6, finnish
 	#Si inserto solo un caracter, el siguiente será \n
 	beq $t1, $t7, finnish
 	#Hago la operacion num = num x 10
 	mult $s0, $t7
   	mflo $s0
   	#Hago la operacion nextChar - '0'
   	subi $s1, $t1, 48
   	#Lo sumo a num
   	add $s0, $s0, $s1
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
