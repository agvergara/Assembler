.data
	stre: .asciiz "El resultado es\n:"
	numero1w: .word 1
	numero2w: .word 2
	numero3hw: .half 3
	numero4hw: .half 4
	numero5b: .byte 5
	numero6b: .byte 6
.text
	lw $t0, numero1w
	lw $t1, numero2w
	add $s0, $t0, $t1
	la $a0, stre
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall 
	#Hasta aqui los .word
	lh $t2, numero3hw
	lh $t3, numero4hw
	add $s1, $t2, $t3
	la $a0, stre
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall 
	#Hasta aqui los .half
	lb $t4, numero5b
	lb $t5, numero6b
	add $s2, $t4, $t5
	la $a0, stre
	li $v0, 4
	syscall
	move $a0, $s2
	li $v0, 1
	syscall 
	#hasta aqui los .byte
	li $v0, 10
	syscall