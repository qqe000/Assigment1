#include "asmdef.h"

.text
.global arraysort
arraysort: # int sortarray(int array[],int length)

j start


#variable list:
#a0: left
#a1: right
#s0: i
#s1: j
#s2: tmp
#s3: pivot
#s4: array access

move $s0, $a0						# i = left
move $s1, $a1						# j = right

add $t0, $a0, $a1					# left + right
div $t0, $t0, 2						# (left + right) / 2
mul $s4, $t0, 4						# array access 
lw $s3, Array($s4)					# pivot = arr[(left + right) / 2]

outsideWhile:
	bgt $s0, $s1, outsideWhileEnd			# if i is bigger j escape while
	
	insideWhile1:
		mul $s4, $s0, 4
		lw $t0, Array($s4) 			#arr[i]
		bge $t0, $s3, insideWhile1End		# escape inside if arr[i] is bigger or equal pivot
		addi $s0, $s0, 1			#i++
		j insideWhile1
	insideWhile1End:
	
	insideWhile2:
		mul $s4, $s1, 4
		lw $t0, Array($s4) 			#arr[j]
		ble $t0, $s3, insideWhile2End		# escape inside if arr[i] is bigger or equal pivot
		subi $s1, $s1, 1			#i++
		j insideWhile2
	insideWhile2End:
	bgt $s0, $s1, whileIfFalse			
		mul $s4, $s0, 4
		lw $s2, Array($s4)				
		
		mul $s4, $s1, 4
		lw $t0, Array($s4)				
		mul $s4, $s0, 4
		sw $t0, Array($s4)				
		
		mul $s4, $s1, 4
		sw $s2, Array($s4)				
		
		addi $s0, $s0, 1				
		subi $s1, $s1, 1				
	whileIfFalse:
	j outsideWhile
outsideWhileEnd:
bge $a0, $s1, if1False					# if left < j{
	sub $sp, $sp, 12
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	move $a0, $a0					
	move $a1, $s1					# right = j
	jal quickSort
	lw $ra, 8($sp)
	lw $a0, 4($sp)
	lw $a1, 0($sp)
	add $sp, $sp, 12
if1False:

bge $s0, $a1, if2False
	sub $sp, $sp, 12
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	move $a0, $s0					# left = i
	move $a1, $a1					
	jal quickSort
	lw $ra, 8($sp)
	lw $a0, 4($sp)
	lw $a1, 0($sp)
	add $sp, $sp, 12
if2False:
jr $ra

start:
addi $a0, $a0, 0
move $a1, $s7
sub $sp, $sp, 12
sw $ra, 8($sp)
sw $a0, 4($sp)
sw $a1, 0($sp)
jal quickSort
lw $ra, 8($sp)
lw $a0, 4($sp)
lw $a1, 0($sp)
add $sp, $sp, 12