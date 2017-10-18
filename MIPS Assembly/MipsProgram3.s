###########################################################
#		Program Description

###########################################################
#		Register Usage
#	$t0
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

###########################################################
		.text
main:


	li $v0, 10		#End Program
	syscall
###########################################################
###########################################################
#		Subprogram Description
#	create_array calls allocat_array and read_array
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp
#	$sp+4	array base address
#	$sp+8	array size
#	$sp+12	ra
###########################################################
#		Register Usage
#	$t0 array base address
#	$t1 array size
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

###########################################################
		.text
create_array:
	addiu $sp, 12		# allocate space on stack for returns from allocate_array and for ra
	sw $ra, 8($sp)		# store ra on stack
	jal allocate_array	# call allocate_array
	
	jal read_array		# arguments in are already on the stack
	
	lw $t0, 0($sp)		# load base address into $t0
	lw $t1, 4($sp)		# load array size into $t1
	lw $ra, 8($sp)		# load return address into $ra	
	
	addiu $sp, -12		# deallocate all space on the stack that was allocated earlier

	lw $t0, 0($sp)		# store base address on stack for caller
	lw $t1, 4($sp)		# store array size on stack for caller

	jr $ra			#return to calling location
###########################################################
###########################################################
#		Subprogram Description
#	allocate_array prompts a user for a size of the array
#	and dynamically allocates memory on the heap fo the array
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp	array base address
#	$sp+4	array size
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0	number of elements in array
#	$t1	array size in bytes
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
	allocate_array_prompt:	.asciiz	"How many elements in the array? "
###########################################################
		.text
allocate_array:
	li $v0, 5	# prompt user
	la $a0, allocate_array_prompt
	syscall

	###### validate user input #####	

	move $t0, $v0	# move user input to $t0	

	li $v0, 9	# syscall for dynamic memory allocation
	sll $t1,$t0, 2
	li $a0, $t0	# number of bytes to be allocated for array
	syscall

	lw $v0, 0($sp)	# move base address onto stack
	lw $t0, 4($0)	# move array size onto stack

	jr $ra	#return to calling location
###########################################################

###########################################################
#		Subprogram Description
#	read_array reads integer values from the user and stores them
#	in the dynamically allocated array
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
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
#	$t0	array base address
#	$t1	array size
#	$t2	counter
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data
	read_array_prompt:	.asciiz	"Enter an integer: "
###########################################################
		.text
read_array:
	lw $t0, 0($sp)	# load base address into register $t0
	lw $t1, 4($0)	# load array size into register $t1

	li $t2, 0	# initialize counter

read_array_loop:
	li $v0, 5
	la $a0, read_array_prompt
	syscall

	li $v0, 4
	syscall

	sw $v0, 0($t0)	# store value in array
	addi $t0, 4	# increment array pointer
	addi $t2, 1

	beq $t2, $t1, read_array_input_done
	b read_array_loop

read_array_input_done:	

	jr $ra	#return to calling location
###########################################################

###########################################################
#		Subprogram Description
#	print_array prints all values from the array
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp	array base address
#	$sp+4	array size
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0	array base address
#	$t1	array size
#	$t2	counter
#	$t3	value from array
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
print_array:
	lw $t0, 0($sp)	# load base address into register $t0
	lw $t1, 4($0)	# load array size into register $t1

	li $t2, 0	# initialize counter

print_array_loop:
	lw $t3, 0($t0)	# load value from array	
	
	li $v0, 1
	li $a0, $t3
	syscall

	li $v0, 11
	li $a0, ' '
	syscall
	
	addi $t0, 4	# increment array pointer
	addi $t2, 1	

	beq $t2, $t1, print_array_input_done
	b print_array_loop

print_array_input_done:	

	jr $ra	#return to calling location
###########################################################
###########################################################
#		Subprogram Description
#	print_every_nth prints every nth value from the array
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp	array base address
#	$sp+4	array size
#	$sp+8	stride N
#	$sp+12
###########################################################
#		Register Usage
#	$t0	array base address
#	$t1	array size
#	$t2	counter
#	$t3	value from array
#	$t4	stride
#	$t5	stride counter
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data

###########################################################
		.text
print_every_nth:
	lw $t0, 0($sp)	# load base address into register $t0
	lw $t1, 4($0)	# load array size into register $t1
	lw $t4, 8($sp)	# load stride into register $t4

	#### check for stride lte 0 #####

	li $t2, 0	# initialize counter
	move $t5, $t4	# initialize stride counter, a value will be printed when the stride counter equals the stride
			# then the stride counter will be reset to 1

print_every_nth_loop:	
	bne $t4, $t5, print_every_nth_dont_print	# if stride counter != to stride, don't print anything

	lw $t3, 0($t0)	# load value from array	
	
	li $v0, 1	# print value
	li $a0, $t3
	syscall

	li $v0, 11
	li $a0, ' '
	syscall
	
	li $t5, 1	# reset stride counter	
	b continue

print_every_nth_dont_print:
	addi $t5, 1	# increment stride counter

continue:
	addi $t0, 4	# increment array pointer
	addi $t2, 1	# increment counter
	beq $t2, $t1, print_every_nth_input_done
	b print_every_nth_loop

print_every_nth_input_done:
	jr $ra	#return to calling location
###########################################################
###########################################################
#		Subprogram Description
#	sum_even_values calculates the sum of all even values in the array
#	and returns the sum
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp	array base address
#	$sp+4	array size
#	$sp+8	sum of even values
#	$sp+12
###########################################################
#		Register Usage
#	$t0	array base address
#	$t1	array size
#	$t2	counter
#	$t3	value from array
#	$t4	sum
#	$t5	result of 1 & $t3
#	$t6	
#	$t7
#	$t8
#	$t9
###########################################################
		.data

###########################################################
		.text
sum_even_values:
	lw $t0, 0($sp)	# load base address into register $t0
	lw $t1, 4($0)	# load array size into register $t1
	li $t2, 0	# initialize counter	

sum_even_values_loop:	
	lw $t3, 0($t0)	# load value from array

	and $t5, $t3, 1	# result will be 0 if value is even

	bne $0, $t5, sum_even_values_odd
	
	add $t4, $t4, $t3 # add to running sum if value is even
	
sum_even_values_odd:
	addi $t0, 4	# increment array pointer
	addi $t2, 1	# increment counter
	beq $t2, $t1, print_every_nth_input_done
	b print_every_nth_loop

print_every_nth_input_done:
	lw $t4, 8($sp)
	jr $ra	#return to calling location
###########################################################
###########################################################
#		Subprogram Description
#	reverse_array reverses the array and returns the base address 
#	of the reversed array
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp	array base address
#	$sp+4	array size
#	$sp+8	reversed base address
#	$sp+12
###########################################################
#		Register Usage
#	$t0	array base address
#	$t1	array size
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

###########################################################
		.text
reverse_array:
	
	jr $ra	#return to calling location
###########################################################
