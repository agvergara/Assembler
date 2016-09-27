.data
	strw: .asciiz "Introduce 2 numeros:\n"
	stre: .asciiz "El resultado es:"
	reserva1: .space 2
	reserva2: .space 4
	numero1w: .word 0
	numero3hw: .half 0
.text
	la $a0, strw
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, numero1w
	li $v0, 5
	syscall
	sh $v0, numero3hw
	lw $t0, numero1w
	lh $t1, numero3hw
	add $s0, $t0, $t1
	la $a0, stre
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall 
	li $v0, 10
	syscall
	#El programa falla ya que el .space no se preocupa de que este alienado o no, solo reserva 2 y 4 bytes por ahi la memoria, es mejor 
	# directamente declarar variables .half y .word
	#Si declaramos variables .word .half directamente, sabemos que estan alineadas, por lo que el error no va a saltar
