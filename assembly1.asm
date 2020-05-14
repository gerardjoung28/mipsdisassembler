##########################################################################
#<J. Alejandro Carrillo>, CS 2318-003, Assignment 2 Part 1 Program A
############################
#Promp the user to entrer a integer and print the integer, 
#then promp the user for a sting and print the string, 
#and ask the user for a chareacter and print the character.
############################ data segment ################################
			.data
string:			.space 16			
inputInteger:		.asciiz "Please enter a integer: "
outputInteger:		.asciiz "The entered integer is: "
inputString:		.asciiz "Please input a string of up to 15 characters long: "
outputString:		.asciiz "The entered string is: "
inputCharacter:		.asciiz "Please enter a character: "
outputCharacter:	.asciiz "\nThe entered character is: "
############################ code segment ################################
			.text
			.globl main
main:
			li $v0, 4
			la $a0, inputInteger
			syscall			# print integer input prompt
			li $v0, 5
			syscall			# read integer
			move $t1, $v0		# save integer read in $v1
			li $v0, 4
			la $a0, outputInteger        
			syscall			# print integer output label
			li $v0, 1
			move $a0, $t1
			syscall			# display desired integer output
			
			li $v0, 11
			li $a0, '\n'		
			syscall			# go to the next line
			
			li $v0, 4
			la $a0, inputString
			syscall			# print string input prompt
			li $v0, 8
			la $a0, string
			li $a1, 16
			syscall			# read up to 15 character string
			li $v0, 4
			la $a0, outputString	# print string output label
			syscall
			#li $v0, 4
			la $a0, string
			syscall			# display desired string output
			
			li $v0, 4
			la $a0, inputCharacter
			syscall			# print character input prompt
			li $v0, 12
			syscall
			move $t1, $v0		# save character read in $t1
			li $v0, 4
			la $a0, outputCharacter        
			syscall			# print character output label
			li $v0, 11
			move $a0, $t1
			syscall			# display desired character output						
			
			li $v0, 10		# exit gracefully
                	syscall
