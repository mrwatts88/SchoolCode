###########################################################
#		Program Description
#
#	Program that dynamically allocates an array at runtime to store user input integers
#	After all input and validation, the array is printed in reverse order
#	along with the sum and average of all elements
###########################################################
#		Register Usage
#	$t0 memory addresses
#	$t1
#	$t2
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data	
array_address:	.word 0
num_elements:	.word 0
sum:		.word 0
sum_p:		.asciiz "\nSum of elements in array: "
###########################################################
		.text
main:	
	jal allocate_array	# call subprogram	

	la $t0, array_address
	sw $v0, 0($t0) 		# base address of array is now in memory as array_address

	la $t0, num_elements
	sw $v1, 0($t0) 		# size of array is now in memory as num_elements
	
	move $a0, $v0 		# put arguments for read_values in $a0 and $a1
	move $a1, $v1

	jal read_values		# call subprogram	

	la $t0, sum
	sw $v0, 0($t0) 		# sum of array's elements is now in memory as sum
	
	la $t0, array_address	# base address of array is now in register $t0
	lw $a0, 0($t0)		# put argument for print_backwards into $a0

	la $t0, num_elements	# size of array is now in $t0
	lw $a1, 0($t0)		# put argument for print_backwards into $a1
	
	jal print_backwards	# call subprogram

	li $v0, 4		# print "sum"
	la $a0, sum_p
	syscall

	la $t0, sum		# load memory address of sum
	lw $a0, 0($t0)		# put argument for print_average into $a0

	la $t0, num_elements	# load memory address of num_elements
	lw $a1, 0($t0)		# put argument for print_average into $a1

	li $v0, 1		# print value of sum
	syscall	

	jal print_average	# call subprogram

	li $v0, 10		# exit program
	syscall

###########################################################
###########################################################
#		Subprogram Description
#	allocate_array: asks the user for the number of integers to be read
#	and dynamically allocates memory to store them
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0	address of memory allocated on heap
#	$v1	number of integers to be read
#	$sp
#	$sp+4
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0	number of bytes to be allocated on heap
#	$t1
#	$t2
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data
prompt_p:	.asciiz "How many integers will be input? "
invalid_p:	.asciiz "Number of integers must be greater than 0.\n\n"
###########################################################
		.text
invalid:
	li $v0, 4 		# print string
	la $a0, invalid_p
	syscall
	
allocate_array:

	li $v0, 4 		# print string
	la $a0, prompt_p
	syscall

	li $v0, 5 		# read integer
	syscall
	move $v1, $v0		# contains number of elements to be read

	ble $v1, $0, invalid	

	sll $t0, $v1, 2		# multiply number of integers to be read by 4 to get the number
				# of bytes to be allocated in memory

	li $v0, 9		# syscall for dynamically allocating space on the heap
	move $a0, $t0		# load amount of space to be allocated into $a0
	syscall			# $v0 now contains the address of the newly allocated space

	jr $ra			# return to calling location

###########################################################
###########################################################
#		Subprogram Description
#	read_values: puts user entered integers into array
# 	and validates all input
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0	base address of array
#	$a1	number of integers to be read
#	$a2
#	$a3
#	$v0	sum of valid numbers read
#	$v1
#	$sp
#	$sp+4
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0   	running sum of integers being read
#	$t1 	counter to indicate when input should stop
#	$t2	pointer to last element in array
#	$t3	= 6 (to determine if divisible by 2 and 3)
#	$t4	remainder
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data
prompt_p2:	.asciiz "Enter a positive integer: "
invalid_entry_p: .asciiz "Number must be positive and divisible by both 2 and 3.\n\n"
###########################################################
		.text
invalid_input:
	li $v0, 4
	la $a0, invalid_entry_p
	syscall

	b loop_read_values

read_values:
	li $t0, 0		# reset $t0
	li $t3, 6

	move $t1, $a1		# move counter to $t1
	move $t2, $a0		# create a pointer to the last element put into the array

loop_read_values:
	li $v0, 4
	la $a0, prompt_p2
	syscall
	
	li $v0, 5		# syscall for read integer
	syscall

	rem $t4, $v0, $t3

	bnez $t4, invalid_input
	ble $v0, $0,  invalid_input	

	add $t0, $t0, $v0 	# add next integer to running sum

	addi $t1, $t1, -1	# decrement counter

	sw $v0, 0($t2)		# store integer in array		

	beqz $t1, input_complete	# branch if counter reaches 0
	
	addi $t2, 4		# move pointer to last element
	
	b loop_read_values

input_complete:
	move $v0, $t0		# move running sum to return register

	jr $ra			# return to calling location

###########################################################

###########################################################
#		Subprogram Description
#	print_backwards: prints each element in the array in reverse order
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0	address of array
#	$a1	number of elements in array
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp
#	$sp+4
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0	($a1-1) * 4
#	$t1	pointer to last element in array ($a0 + $t0)
#	$t2	loop counter
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data
###########################################################
		.text
print_backwards:
	move $t2, $a1		# initialize counter

	addi $t0, $a1, -1	# (number of elements minus 1) * 4 + base address = address
	sll $t0, $t0, 2		# of last element in array
	add $t1, $a0, $t0				

loop_print_backwards:	
	li $v0, 1		# syscall for print integer
	lw $a0, 0($t1)		# load last element of array into $a0
	syscall

	li $v0, 11		# new line
	li $a0, '\n'
	syscall

	addi $t2, $t2, -1	# decrement counter	

	beqz $t2, output_done	# branch if counter reaches 0

	addi $t1, $t1, -4	# move pointer to previous element

	b loop_print_backwards

output_done:
	jr $ra	#return to calling location
###########################################################

###########################################################
#		Subprogram Description
#	print_average: calculates and prints the average of all elements in the array
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0	sum of elements
#	$a1	number of elements
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp
#	$sp+4
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0	integer result of division
#	$t1	remainder of division
#	$t2	counter
#	$t3	10
#	$t4	boolean, init to 1, changed to 0 after printing radix pt, so it won't print again
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data
average_p:	.asciiz	"\nAverage of elements in array: "
###########################################################
		.text
print_average:
	li $t3, 10
	li $t4, 1
	li $t2, 5		# initialize counter
	move $t0, $a0

	li $v0, 4
	la $a0, average_p
	syscall			# print prompt

loop_print_average:
	div $t0, $a1
	mflo $a0	
	li $v0, 1
	syscall			# print integer portion of average

	mfhi $t0		# move remainder
	mult $t0, $t3		# add a 0 to end of number
	mflo $t0
	
	addi $t2, $t2, -1	# decrement counter

	beqz $t2, printing_done # printing done if counter reaches 0
	beqz $t4, loop_print_average
	
	li $v0, 11
	li $a0, '.'
	syscall	

	li $t4, 0		# change boolean

	b loop_print_average

printing_done:	

	jr $ra			#return to calling location

###########################################################
