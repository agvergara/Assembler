#Practica5 -> Treesort
.data
	new_line: .asciiz "\n"
	no_memory: .asciiz "No hay memoria para reservar"
	nodo: .asciiz "Imprimo un nodo (nodo raiz: centro; arbol izquierdo: arriba; arbol derecho: abajo): "
.text
main: li $s2, 0 
	move $a0, $s2
	li $a1, 0
	li $a2, 0
	jal tree_node_create
	move $s0, $v0

in_loop:
	li $v0, 5
	syscall
	#Muevo el valor que he introducido y lo comparo con el valor centinela (0)
	move $s1, $v0
	beq $s1, $s2, in_end
	#Muevo los valores a registros estáticos para que pueda acceder tree_insert
	move $a0, $s1
	move $a1, $s0
	jal tree_insert
	b in_loop
	
in_end:
	#Cargo lo que hay en 4($s0) (nodo izquierdo del arbol) para pasarselo a tree_print
	lw $a0, 4($s0)
	jal print_tree
	#Cargo lo que hay un 8($s0) (nodo derecho del arbol) para pasarselo a tree_print
	lw $a0, 8($s0)
	jal print_tree
	b exit
	
tree_node_create:
	#Reservo pila para guardar todo
	subu $sp, $sp, 32
	sw $ra, 28($sp)
	sw $fp, 24($sp)
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	addu $fp, $sp, 32
	#Muevo los valores que anteriormente he introducido
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	#Miro a ver si puedo reservar los 12 bytes de memoria con sbrk
	li $a0, 12
	li $v0, 9
	syscall
	#sbrk devuelve (en $v0) la direccion donde me ha reservado los 12 bytes
	move $s3, $v0
	#Comprobamos si nos hemos quedado sin memoria y si no, pues guardo todo
	beqz $s3, sin_memoria
	sw $s0, 0($s3)
	sw $s1, 4($s3)
	sw $s2, 8($s3)
	#En caso de haberme cargado $v0, mejor lo copio otra vez
	move $v0, $s3
	#Cargo los valores otra vez y libero la pila
	lw $ra, 28($sp)
	lw $fp, 24($sp)
	lw $s0, 20($sp)
	lw $s1, 16($sp)
	lw $s2, 12($sp)
	lw $s3, 8($sp)
	addu $sp, $sp, 32
	jr $ra

tree_insert:
	#Creo una nueva pila para insertar el nodo
	subu $sp, $sp, 32
	sw $ra, 28($sp)
	sw $fp, 24($sp)
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	sw $s3, 4($sp)
	addu $fp, $sp, 32
	#Cojo los parámetros siendo a0 el que meto y el s1 el nodo raiz
	move $s0, $a0
	move $s1, $a1
	move $a0, $s0
	#Hacemos un nuevo nodo
	li $a1, 0
	li $a2, 0
	jal tree_node_create
	#Guardo el valor en $s2 (nodo centinela)
	move $s2, $v0
#Realizo un bucle para buscar el menor/mayor, si el valor que hay en $s1 es menor que el valor introducido ($s0) vamos al nodo izquierdo
loop_search:
	lw $s3, 0($s1)
	ble $s0, $s3, left_node
	b right_node
#Si el valor que hay en 4($s1) es cero (es decir, un nodo vacio izquierdo) lo añado a la izquierda
left_node:
	lw $s4, 4($s1)
	beqz $s4, add_left
	move $s1, $s4
	b loop_search
	
add_left:
	sw $s2, 4($s1)
	b end_loop_search
#Si el valor que hay en 8($s1) es cero (es decir, un nodo vacio derecho), lo añado a la derecha
right_node:
	lw $s4, 8($s1)
	beqz $s4, add_right
	move $s1, $s4
	b loop_search	
add_right:
	sw $s2, 8($s1)
	b end_loop_search	
end_loop_search:
	#Necesito todos los valores, por lo que tengo que cargarlos de la pila y vuelvo de donde me han llamado.
	lw $ra, 28($sp)
	lw $fp, 24($sp)
	lw $s0, 20($sp)
	lw $s1, 16($sp)
	lw $s2, 12($sp)
	lw $s3, 8($sp)
	lw $s4, 4($sp)
	addu $sp, $sp, 32
	jr $ra	
print_tree:
	subu $sp, $sp, 32
	sw $ra, 28($sp)
	sw $fp, 24($sp)
	sw $s0, 20($sp)
	addu $fp, $sp, 32
	
	move $s0, $a0
	beqz $s0, end_print
	#Imprimo el nodo izquierdo
	lw $a0, 4($s0)
	jal print_tree
	#imprimo el valor que me devuelven en cada linea
	la $a0, nodo
	li $v0, 4
	syscall
	lw $a0, 0($s0)
	li $v0, 1
	syscall
	la $a0, new_line
	li $v0, 4
	syscall
	#Imprimo el nodo derecho
	lw $a0, 8($s0)
	jal print_tree	
end_print:
	lw $ra, 28($sp)
	lw $fp, 24($sp)
	lw $s0, 20($sp)
	addu $sp, $sp, 32
	jr $ra	
sin_memoria:
	la $a0, no_memory
	li $v0, 4
	syscall	
exit: 
	li $v0, 10
	syscall