#Practica 4A
.data
	msgw: .ascii "Introduce un numero: "
	msge: .asciiz "El numero de Fibonacci corresponde con: "
	
.text
	
	la $a0, msgw
	li $v0, 4 # Load syscall print-string into $v0 
	syscall
	li $v0, 5
	syscall
	
	move $a0, $v0
	jal fibonacci
	
	move $t0, $v0
	
	la $a0, msge
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
fibonacci:
	#a0=a
	#if (a==0) return 0;
	#if (a<2) return 1;
  
	#    int x($t0),y($t1),z($t2),i($t3);
	#    for (x=0,y=0,z=1,i=1;i<a;i++) {
	#        x=y+z;
	#        y=z;
	#        z=x;   }   

	#    return(x);
	beq $a0, $zero, return0
	ble $a0, 2, return1
	move $t0, $zero
	move $t1, $zero
	li $t2, 1
	li $t3, 1
loop:
	bge $t3, $a0, endloop
	add $t0, $t1, $t2
	move $t1, $t2
	move $t2, $t0
	addi $t3, $t3, 1
	b loop	
	
endloop:
	move $v0, $t0
	jr $ra	
	
return0:
	move $v0, $zero
	jr $ra
	
return1:
	li $v0, 1
	jr $ra
	
