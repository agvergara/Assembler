.data
	strw: .asciiz "Introduce 2 numeros: \n"
	numero1: .word 0
	numero2: .word 0
	strmult: .asciiz "Numero multiplo: "
	retornocarro: .asciiz "\n"
	contador: .word 0
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
	lw $s0, numero1
	lw $s1, numero2
	lw $t8, contador
	mult $s0, $s1
	mflo $t9
	beqz $s1, if
	bgtz $s1, for
	
	for:ble $t8, $t9, else
	bgt $t8, $t9, if
	
	
	if: li $v0, 10
	syscall
	
	else:
	mult $s0, $t8
	la $a0, strmult 
	li $v0, 4 
	syscall
	li $v0, 1
	mflo $a0
	syscall
	la $a0, retornocarro
	li $v0, 4
	syscall
	addi $t8, $t8, 1
	#Guarda en $t8 el resultado de $t8 + 1
	bgtz $s0, for