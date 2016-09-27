.data 
msg: .asciiz "The factorial of 3 is: " 

.text
main: 
	li $s0, 1
	
	la $a0, msg
	li $v0, 4 # Load syscall print-string into $v0 
	syscall
	
	li $a0, 3 #Put argument (3) in $a0
	jal fact #Call factorial function
	
	move $a0, $v0  #Move fact result in $a0
	li $v0, 1  #Load syscall print-int into $v0
	syscall
	
	li $v0, 10	#Load syscall exit into $v0
	syscall  #Make the syscall
	
fact: 
	bgt $a0, $s0, fact_recurs #Si $a0 es más grande que cero, quiere decir que puedo calcular el factorial y directamente usar $a0 en vez de acceder a la pila.
	li $v0, 1 #En caso de que sea 0, el factorial es 1, entonces pongo un 1 en el registro de retorno $v0 y voy a return
	jr $ra
	
fact_recurs: #ELSE
	#Me creo la pila SOLO cuando entro por el else
	subu $sp, $sp, 32 #Me hago otra pila para cada factorial
	sw $ra, 20($sp)
	sw $fp, 16($sp) #Guardo mis return address y frame pointer de ESTE factorial para volver cuando quiera y los guardo en la posicion -32 + 16 = -16 del 
				#stack para el fp y en la posicion -12 para el $ra
	addiu $fp, $sp, 28 #Pongo mi frame pointer apuntando a mi primera palabra, es decir, en la posicion -2 del stack ya que he guardado ya 2 registros.
	sw $a0, 0($fp) #Guardo $a0 en la posicion 0+$fp, es decir, lo guardo en la posicion DONDE ESTÉ APUNTANDO EL FP.
	subu $v0, $a0, 1 #Hago n - 1 y lo guardo en el registro de retorno $v0, uso $a0 por que todavía no me lo he cargado, las instrucciones de
					#branch no son llamadas a subrutina
	move $a0, $v0 #Lo muevo a $a0 para que sea un paso de parametros.
	jal fact #Vuelvo a llamar a fact PERO CON $a0 COMO PARAMETRO, AQUI SERÍA $a0 = 2
	
	lw $v1, 0($fp) #AHORA SI, cargo en $v1 n, por que ya me he cargado $a0.
	mul $v0, $v0, $v1 #Realizo la multiplicacion del registro de retorno $v1 (n) por el registro $v0  n-1

 return: 
 	lw $ra, 20($sp) #Cargo la direccion de retorno que habia guardado previamente en fact
 	lw $fp, 16($sp) #Cargo el frame pointer que habia guardado previamente en fact
 	addiu $sp, $sp, 32 
 	jr $ra #Vuelvo a la instruccion + 1 que habia almacenado previamente en fact.
	
	
