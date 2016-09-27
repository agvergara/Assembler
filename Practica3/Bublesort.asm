#Bublesort
.data
	numbers: .word 0
	strw: .asciiz "Escribe una cadena de caracteres (max 20 enteros): \n"

.text
	#Cambiar $s4 a 20 que es mi total de numeros
	li $t1, 4
	li $s4, 5
	li $s5, 0
	la $t0, numbers
	move $t4, $t0
	move $t5, $t0
	move $t6, $t0
	move $t9, $t0
	move $t8, $t0
	#$t0 y $t9 son mis direcciones de memoria
	#t0 será mi direccion de memoria +1 (en realidad +4 bytes)
	#$t3, $t4 y $t5 son mis registros de offset para guardar los numeros ya corregidos
	addi $t0, $t0, 4
	addi $t6, $t6, 4
	mult $s4, $t1
	mflo $t1
	#Uso 12 por que son 12 bytes que añado al array 3 numeros por 4 bytes cada
	add $s6, $t9, $t1
	li $s3, 0
	#$s3 lo uso como un boleano, $t1 como un contador
	li $t1, 0
	la $a0, strw
	li $v0, 4
	syscall
	
for_int:	li $v0 5
	syscall
	sw $v0, 0($t8)
	addi $t8, $t8, 4
	addi $s5, $s5, 1
	beq $s4, $s5, bublesort
	bne $s4, $s5, for_int
	
bublesort:
	lw $t2, 0($t9)
	lw $t3, 0($t0)
	ble $t2, $t3, update
	bgt $t2, $t3, is_bigger
	beqz $s3, print
	li $s3, 0
	beq $t1, $s4, start_again
	
update:	addi $t1, $t1, 1
	addi $t9, $t9, 4
	addi $t0, $t0, 4
	addi $t4, $t4, 4
	addi $t6, $t6, 4
	b bublesort

print:
	lw $t2, 0($t5)
	move $a0, $t2
	li $v0, 1
	syscall
	addi $t5, $t5, 4
	bne $t5, $s6, print
	beq $t5, $s6, finnish	
	
is_bigger:
	move $t8, $t2
	move $t7, $t3
	move $t3, $t8
	move $t2, $t7
	#Uso $t4 como direccionamiento (offset) para ir sumando 4 a 4 bytes que ocupa un int
	# Y $t6 para ser el offset + 1
	sw $t2, 0($t4)
	sw $t3, 0($t6)
	addi $t4, $t4, 4
	addi $t6, $t6, 4
	addi $t0, $t0, 4
	addi $t9, $t9, 4
	addi $t1, $t1, 1
	li $s3, 1
	b bublesort
	
start_again:
	la $t0, numbers
	move $t4, $t0
	move $t5, $t0
	move $t6, $t0
	move $t9, $t0
	move $t8, $t0
	#$t0 y $t9 son mis direcciones de memoria
	#t0 será mi direccion de memoria +1 (en realidad +4 bytes)
	#$t3, $t4 y $t5 son mis registros de offset para guardar los numeros ya corregidos
	addi $t0, $t0, 4
	addi $t6, $t6, 4
	li $t1, 0
	b bublesort
	
finnish:
	li $v0, 10
	syscall
