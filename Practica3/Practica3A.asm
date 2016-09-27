.data
	strw: .asciiz "Introduce 2 numeros: \n"
	numero1: .word 0
	numero2: .word 0
	strmayor: .asciiz "Es mayor el primer numero introducido\n"
.text
	
	la $a0, strw
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, numero1
	li $v0, 5
	syscall
	sw $v0, numero2
	#Lee 2 numeros por el usuario y los guarda en memoria
	lw $t0, numero1
	lw $t1, numero2
	#Carga los 2 numeros de la memoria
	bgt $t0, $t1, if
	#Si $t0 > $t1 salta a la etiqueta "if" si no, acaba la ejecucion (else)
	li $v0, 10
	syscall
	
	if: la $a0, strmayor
	li $v0, 4
	syscall
	li $v0, 10
	syscall