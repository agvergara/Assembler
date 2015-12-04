#Examen 9 Diciembre 2014 ISAM Practicas
.data
	str1: .space 256
	str2: .space 256
	first: .asciiz "First string: "
	second: .asciiz "Second string: "
	return: .asciiz "\0"
.text

main:
	#Max: 256 chars
	li $a1, 256
	la $a0,first
	li $v0, 4
	syscall
	la $a0, str1
	jal read_str
	move $s0, $v0
	la $a0,second
	li $v0, 4
	syscall
	la $a0, str2
	jal read_str
	move $s1, $v0
	#Both addresses
	la $a0, str1
	la $a1, str2
	jal strcpy
	#Print both strings
	
	la $a0,first
	li $v0, 4
	syscall
	la $a0,str1
	li $v0, 4
	syscall
	
	la $a0,second
	li $v0, 4
	syscall
	la $a0,str2
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
	
	
read_str:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	
	li $v0, 8
	syscall
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addu $sp, $sp, 32
	jr $ra
	
strcpy:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	#a0 address 
	jal strlen
	move $t0, $v0
	add $t0, $t0, $a0
loop_cpy:
	
	lb $t1, 0($a0)
	sb $t1, 0($a1)
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $a0, $t0, end_loopcpy
	b loop_cpy
	
end_loopcpy:
	li $t0, 0
	sb $t0, 0($a1)
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addu $sp, $sp, 32
	jr $ra	
	
	
strlen:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	#I cannot use a0, need it later
	
	move $t1, $a0
	move $v0, $zero
loop_len:	
	lb $t0, 0($t1)
	beq $t0, 0, end_looplen
	addi $t1, $t1, 1
	addi $v0, $v0, 1
	b loop_len
	
end_looplen:
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addu $sp, $sp, 32
	jr $ra
	
