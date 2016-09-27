#Palindromos
.data
	strw: .asciiz "Escribe una cadena de caracteres: \n"
	string: .space 1024
	str_pal: .asciiz "Es palindromo \n"
.text
	
main:
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
	
for_end: 
	#t7 para hallar el fin de la palabra
	lb $t2, 0($t9)
	beq $t2, $t7, palindrom
	addi $t9, $t9, 1
	bne $t2, $t7, for_end
	
palindrom:
	#$t0 para indice del punter AL PRINCIPIO
	#$t9 para indice del puntero AL FINAL
	lb $t1, 0($t0)
	subi $t9, $t9, 1
	lb $t2, 0($t9)
	beq $t1, $t2, is_equal
	bne $t1, $t2, finish
	
is_equal:
	addi $t0, $t0, 1
	ble $t0, $t9, palindrom
	bgt $t0, $t9, finish_ok
	
finish: li $v0, 10
	syscall
	
finish_ok: la $a0, str_pal
		li $v0, 4
		syscall
		li $v0, 10
		syscall
	
