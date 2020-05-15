##########################################################################
#<J. Alejandro Carrillo>, CS 2318-003, Assignment 2 Part 1 Program C
############################
# Allocate a global array storing 4 integers and initialize the array 
#(from 1st to 4th element) with 2, 3, 1 and 8
# Display a labeled output about the array's initial contents 
# (from 1st to 5th element).Re-order the values in the array 
# so that the contents of the array in memory (from 1st to 5th element) 
# becomes 8, 1, 3 and 2, using the following operations in that order
# Swap the contents in memory of the 1st and 4th elements of the array.
# Swap the contents in memory of the 2nd and 3th elements of the array.
# Display a labeled output about the array's contents (from 4th to 1st element) 
# after the 2 swapping operations above.
############################ data segment ################################
			.data
intArr:			.word 2, 3, 1, 8	# global int array of size 4 initialized
						# to 2, 3, 1 & 8 (from 1st to 4th)
outputLabel:		.asciiz "The content of the array from 1st to 4th element is: "
outputLabel2:		.asciiz "The content of the array from 4th to 1st element now is: "
############################ code segment ################################			 			
			.text
			.globl main
main:
			li $v0, 4
			la $a0, outputLabel
			syscall			# print output label
			
			# BEGIN_printing elementes of the array
			la $t0, intArr		# $t0 has address of intArr
			li $v0, 1
			lw $a0, 0($t0)
			syscall			# print 1st element of the array
			li $v0, 11
			li $a0, ' '
			syscall			# print a space
			
			li $v0, 1
			lw $a0, 4($t0)
			syscall			# print 2nd element of the array
			li $v0, 11
			li $a0, ' '
			syscall			# print a space
			
			li $v0, 1
			lw $a0, 8($t0)
			syscall			# print 3rd element of the array
			li $v0, 11
			li $a0, ' '
			syscall			# print a space
			
			li $v0, 1
			lw $a0, 12($t0)
			syscall			# print 4th element of the array
			
			li $v0, 11
			li $a0, '\n'
			syscall			# print a new line
			  
			# BEGIN_(swapping intArr[0] & intArr[3] in memory)
			lw $t4, 0($t0)		# $t4 has oneInt[0] (should be 2)
			lw $t1, 12($t0)		# $t1 has oneInt[3] (should be 8)
			sw $t1, 0($t0)		# put "int in $t1" to intArr[0] in memory
			sw $t4, 12($t0)		# put "int in $t4" to intArr[3] in memory
			
			lw $t3, 4($t0)		# $t5 has oneInt[1] (should be 3)
			lw $t2, 8($t0)		# $t4 has oneInt[4] (should be 1)
			sw $t2, 4($t0)		# put "int in $t2" to intArr[1] in memory
			sw $t3, 8($t0)		# put "int in $t3" to intArr[2] in memory
			li $v0, 4
			la $a0, outputLabel2	# print 2nd output label
			syscall
			
			# BEGIN_printing elementes of the array
			li $v0, 1
			lw $a0, 12($t0)
			syscall			# print new 4th element of the array
			li $v0, 11
			li $a0, ' '
			syscall			# print a space
			
			li $v0, 1
			lw $a0, 8($t0)
			syscall			# print 3rd element of the array
			li $v0, 11
			li $a0, ' '
			syscall			# print a space
			
			li $v0, 1
			lw $a0, 4($t0)
			syscall			# print new 2nd element of the array
			li $v0, 11
			li $a0, ' '
			syscall			# print aspace
			
			li $v0, 1
			lw $a0, 0($t0)
			syscall			# print new 1st element of the array
			
			li $v0, 10		# exit gracefully
			syscall
