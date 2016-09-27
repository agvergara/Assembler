#Numeros primos
.data
	str: .asciiz "Los 100 primeros numeros primos son: "
	space: .ascii " "
	
.text
	la $a0, str
	li $v0, 4
	syscall
	li $a0, 1
	li $s2, 1
main:
	#$s0 lo utilizo para dividir
	#$s1 lo uso para ver si es primo
	#$s2 lo uso para contar cuantos primos llevo
	li $s0, 1
	li $s1, 1
	addi $a0, $a0, 1
	jal test_prime
	bnez $v0, print
	bne $s2, 100, main
	
test_prime:
	div $a0, $s0
	mfhi $t0
	beq $s0, $a0, endloop
	bnez $t0, not_prime
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	b test_prime
	
not_prime:
	addi $s0, $s0, 1
	b test_prime
	
endloop:
	beq $s1, 2, is_prime
	move $v0, $zero
	jr $ra

is_prime:
	addi $s2, $s2, 1
	li $v0, 1
	jr $ra
	
print: 
	li $v0, 1
	syscall
	move $a1, $a0
	la $a0, space
	li $v0, 4
	syscall
	move $a0, $a1
	b main