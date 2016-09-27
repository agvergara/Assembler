#Practica 2A
#Antonio Gomez Vergara
.data
	strw: .asciiz "Introduce 2 numeros: \n"
	strend: .asciiz "El resultado es: "
.text
	la $a0, strw
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 5
	syscall
	move $t1, $v0
	add $t2, $t0, $t1
	la $a0, strend
	li $v0, 4
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
