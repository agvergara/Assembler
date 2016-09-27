#Palindromos2
.data
	strw: .asciiz "Escribe una cadena de caracteres: \n"
	string: .space 1024
	str_pal: .asciiz "Es palindromo \n"
.text
	
main:
	#En el registro $s0 introduzco el equivalente en ASCII de \n
	#En el registro $s1 introduzco el equivalente en ASCII al espacio
	#En el registro $s2 introduzco el equivalente en ASCII del punto
	#En el registro $s3 introduzco el equivalente en ASCII de la coma
	#En el registro $s4 introduzco el equivalente en ASCII de 'A'
	#En el registro $s5 introduzco el equivalente en ASCII de 'Z'
	#En el registro $s6 introduzco el equivalente en ASCII de '0'
	#En el registro $s7 introduzco el equivalente en ASCII de '9'

	li $s0, 10
	li $s1, 32
	li $s2, 46
	li $s3, 44
	li $s4, 65
	li $s5, 90
	li $s6, 48
	li $s7, 57

	la $a0, strw
	li $v0, 4
	syscall
	li $v0 8
	la $a0, string
	li $a1, 1024
	syscall
	la $t0, string
	move $t9, $t0
	
for_end: 
	#s0 para hallar el fin de la palabra
	lb $t2, 0($t9)
	beq $t2, $s0, eol
	addi $t9, $t9, 1
	bne $t2, $s0, for_end
	
palindrom:
	#$t0 para indice del punter AL PRINCIPIO
	#$t9 para indice del puntero AL FINAL
	lb $t1, 0($t0)
	lb $t2, 0($t9)
	
comparison:	
	beq $t1, $s1, is_symbol_fpointer
	beq $t1, $s2, is_symbol_fpointer
	beq $t1, $s3, is_symbol_fpointer
	ble $t1, $s7, is_number
	ble $t1, $s5, bigger_than_fA
	
	beq $t2, $s1, is_symbol_spointer
	beq $t2, $s2, is_symbol_spointer
	beq $t2, $s3, is_symbol_spointer
	ble $t2, $s7, is_number
	ble $t2, $s5, bigger_than_sA
	
	beq $t1, $t2, is_equal
	bne $t1, $t2, finish
	
is_equal:
	addi $t0, $t0, 1
	subi $t9, $t9, 1
	ble $t0, $t9, palindrom
	bgt $t0, $t9, finish_ok
	
finish: li $v0, 10
	syscall
	
finish_ok: la $a0, str_pal
		li $v0, 4
		syscall
		li $v0, 10
		syscall
		
is_symbol_fpointer:
		addi $t0, $t0, 1
		jal palindrom
	
is_symbol_spointer:
		subi $t9, $t9, 1
		jal palindrom
eol:
	subi $t9, $t9, 1
	jal palindrom
	
trans_minusf:
	addi $t1, $t1,32
	jal comparison
	
trans_minuss:
	addi $t2, $t2,32
	jal comparison
	
bigger_than_fA:
	bge  $t1, $s4, trans_minusf

	
bigger_than_sA:
	bge $t2, $s4, trans_minuss

is_number: 
	beq $t1, $t2, is_equal
	
	
	
