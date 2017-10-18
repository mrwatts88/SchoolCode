#############################################################################################################
#		Program Description
#############################################################################################################
#		Register Usage
#	$t0 counter
#	$t1 input
#	$t2 0 if positive and even
#	$t3 running sum
#	$t4 = -9
#	$t5 static variable addresses
#	$t6 average
#	$t7 = -2147483647
#	$t8 = 10
#	$t9 
#############################################################################################################
		.data

number_p:   .asciiz "Enter Number: "
invalid_input_p: .asciiz "Numbers must be non-negative and even to be counted.\n"
sum_p: .asciiz "\nSum of valid numbers entered:\n"
valid_count_p: .asciiz "\nNumber of valid numbers entered:\n"
average_p: .asciiz "\nInteger average of valid numbers entered:\n"

sum:	.word 0 # static variables to hold results
count:	.word 0
average:.word 0

#############################################################################################################
		.text
error:					# branch to here when input is invalid
	li $v0, 4
	la $a0, invalid_input_p
	syscall
	b loop_start

main:					# initializing registers
	li $t0, 0
	li $t3, 0		
	li $t4, -9
	li $t6, 0			
	li $t7, -2147483647		# binary number starts and ends in 1's with 0's everywhere else
	li $t8, 10

loop_start:
	li $v0, 4			# prompt for input
	la $a0, number_p
	syscall

	li $v0, 5			# read input
	syscall

	move $t1, $v0
	
	beq $t1, $t4, input_done  	# branch if input was -9

	and $t2, $t1, $t7 		# if this result == 0, it is a positive and even number

	bnez $t2, error 		# prompt again if not valid

	addi $t0, $t0, 1  		# increment counter if valid

	add $t3, $t3, $t1  		# add input to running total
	
	beq $t0, $t8 input_done		# branch if 10 valid numbers have been input

	b loop_start

input_done:
	li $v0, 4			# display sum
	la $a0, sum_p
	syscall

	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 11			# syscall 11 prints a value as its ascii equivalent
	li $a0, 10			# new line
	syscall

	li $v0, 4			# display count of valid numbers
	la $a0, valid_count_p
	syscall

	li $v0, 1
	move $a0, $t0
	syscall	

	li $v0, 11	
	li $a0, 10			# new line
	syscall	
	
	beqz $t0, div_by_zero		# skip computing average if denominator is 0. $t6 was initialized
					# to 0 and will be printed as the average

	div $t6, $t3, $t0		# compute average

div_by_zero:
	li $v0, 4			# display average
	la $a0, average_p
	syscall

	li $v0, 1
	move $a0, $t6
	syscall

	la $t5, sum			# storing results in memory at location of declared static variables.
	sw $t3, 0($t5)			# This can be done by using the variable name as the second argument,
	la $t5, count			# but I did not see it done that way in the notes, so I loaded the
	sw $t0, 0($t5)			# address first, then stored the value
	la $t5, average	
	sw $t6, 0($t5)

	li $v0, 10			#End Program
	syscall
#############################################################################################################

