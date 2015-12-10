#ISAM 9 Dec 2015
#NOTE TO SELF, DONT CHANGE THE VALUE OF $S REGISTER IN FUNCTION CALLS
.data
	#With length 7, so 1 integer = 4 bytes -> 7*4 = 28 bytes
	array: .word 1:7
	str: .asciiz "Write a number (-1 to stop or 7 numbers MAX): "
	strpos: .asciiz "Write position to start to find: "
	strnum: .asciiz "Write the int to find in the array: "
.text
main:
	#$a3 contains the static length of the array
	li $a3, 7
	la $a0, str
	li $v0, 4
	syscall
	la $a0, array
	jal loop_array
	
	la $a0, strpos
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	#$a1 contains the position to start to find
	move $a1, $v0
	
	la $a0, strnum
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	#$a2 contains the int to find.
	move $a2, $v0
	la $a0, array
	#Want to get the END of the  array just in case it will not overflow
	addi $s0, $a0, 28
	jal find	
	beq $v0, -1, finnish
	move $a0, $v0
	#End of the array (the address +0 is included)
	la $a1, array
	addi $a2, $a1, 24
	jal change
	jal print

finnish:li $v0, 10
	syscall

loop_array:
	#Finnnish if all array spaces are full (7 numbers)
	#Or $v0 has -1 (-1 is for error later)
	beq $t0, 7, end_loop
	li $v0, 5
	syscall
	sw $v0, 0($a0)
	beq $v0, -1, end_loop
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	b loop_array
	
end_loop:
	jr $ra	
	
find:	
	mul $a1, $a1, 4
	add $a0, $a0, $a1
	
find_from: subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addu $fp, $sp, 28
	
	bgt $a0, $s0, end_notfound
	lw $t0, 0($a0)
	beq $t0, $a2, end_founded
	
	addi $a0, $a0, 4
	jal find_from
	beq $v0, -1, end_notfound
	
end_founded:lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	move $v0, $a0
	jr $ra
	
end_notfound: lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	li $v0, -1
	jr $ra
	
change:
	lw $t0, 0($a0)
	lw $t1, 4($a0)
	beq $t1, -1, end_change
	beq $a0, $a2, end_change
	sw $t1, 0($a0)
	sw $t0, 4($a0)
	jr $ra
	
end_change:
	jr $ra
	
print:	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addu $fp, $sp, 28
	
	lw $a0, 0($a1)
	beq $a0, -1, end_print
	li $v0, 1
	syscall
	
	beq $a1, $a2, end_print
	addi $a1, $a1, 4
	jal print
	
end_print:lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra	
	 
	
