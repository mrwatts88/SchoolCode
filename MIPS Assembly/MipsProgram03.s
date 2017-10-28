######################################################################################################################
#		Program Description
#		This program creates an array of a user specified size by 
#		dynamically allocating memory after user input. 
#		The array is then printed, the even values are summed and
#		that sum is printed.  The array is then reversed, and
#		every nth element is printed, where n is specified by the user.
######################################################################################################################
#		Register Usage
#	$t0	base address array
#	$t1 base address reversed array
#	$t2	array size
#	$t3 address of "base_address" static variable
#	$t4	address of "array_size" static variable
#	$t5 sum of even values
#	$t6	address of "reverse_base_address" static variable
#	$t7 stride size
#	$t8
#	$t9
######################################################################################################################
		.data
sum_even_prompt:		.asciiz "Sum of even values: "
base_address:			.word 0
reverse_base_address:	.word 0
stride_prompt:			.asciiz "Enter stride size: "
array_size:				.word 0
######################################################################################################################
		.text
main:
	addiu $sp, $sp, -12					# allocate space on stack for returns from create_array (and extra so we can call sum_even_values later)

	jal create_array	
	
	lw $t0, 0($sp)
	la $t3, base_address
	sw $t0, 0($t3)						#storing base address in static variable "base_address"

	lw $t2, 4($sp)
	la $t4, array_size
	sw $t2, 0($t4)						# storing array size in static variable "array size"

	jal print_array						# stack is already prepared for calling print_array

	li $v0, 11
	li $a0, '\n'
	syscall

	jal sum_even_values
	
	lw $t5, 8($sp)						# load sum of even values from stack

	li $v0, 4
	la $a0, sum_even_prompt
	syscall
	
	li $v0, 1							# print sum of even values
	move $a0, $t5
	syscall

	li $v0, 11
	li $a0, '\n'
	syscall
	
	jal reverse_array					# stack is already prepared for calling reverse_array ($sp+8 will be overwritten)

	lw $t1, 8($sp)						# load base address of reversed array from stack
	la $t6, reverse_base_address
	sw $t1, 0($t6)						# storing base address in static variable "reverse_base_address"

	sw $t1, 0($sp)						# store reverse base address on stack to pass to print_every_nth

	li $v0, 4
	la $a0, stride_prompt
	syscall

	li $v0, 5
	syscall

	move $t7, $v0	
	sw $t7, 8($sp)						# pass stride size to stack

	jal print_every_nth					# array size is still in 4($sp);									

	li $v0, 10							# End Program
	syscall
######################################################################################################################
######################################################################################################################
#		Subprogram Description
#		create_array calls allocat_array and read_array
######################################################################################################################
#		Arguments In and Out of subprogram
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp		array size
#	$sp+4	base address
#	$sp+8	ra
#	$sp+12	
######################################################################################################################
#		Register Usage
#	$t0 array base address
#	$t1 array size
#	$t2 4
#	$t3 11
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
######################################################################################################################
		.data
create_array_prompt:			.asciiz	"How many elements in the array? "
create_array_invalid_prompt:	.asciiz "Number of elements must be greater than 3 and less than 11.\n"
######################################################################################################################
		.text
create_array_invalid:
	li $v0, 4
	la $a0, create_array_invalid_prompt
	syscall

	b skip_load

create_array:
	li $t2, 4
	li $t3, 11

skip_load:
	li $v0, 4							# prompt user
	la $a0, create_array_prompt
	syscall

	li $v0, 5
	syscall

	blt $v0, $t2, create_array_invalid	# validate user input [4,11)		
	bge $v0, $t3, create_array_invalid	

	addiu $sp, -12						# allocate space on stack for returns from allocate_array and for ra
	sw $v0, 0($sp)						# store array size on stack
	sw $ra, 8($sp)						# store ra on stack

	jal allocate_array					# call allocate_array	

	lw $t0, 4($sp)						# load base address into $t0
	lw $t1, 0($sp)						# load array size into $t1

	sw $t0, 0($sp)						# store base address onto stack
	sw $t1, 4($sp)						# store array size onto stack

	jal read_array						# arguments in are already on the stack
	
	lw $t0, 0($sp)						# load base address into $t0
	lw $t1, 4($sp)						# load array size into $t1
	lw $ra, 8($sp)						# load return address into $ra	
	
	addiu $sp, 12						# deallocate all space on the stack that was allocated earlier

	sw $t0, 0($sp)						# store base address on stack for caller
	sw $t1, 4($sp)						# store array size on stack for caller

	jr $ra								# return to calling location
######################################################################################################################
######################################################################################################################
#		Subprogram Description
#		allocate_array prompts a user for a size of the array
#		and dynamically allocates memory on the heap fo the array
######################################################################################################################
#		Arguments In and Out of subprogram
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp		array size
#	$sp+4	array base address
#	$sp+8
#	$sp+12
######################################################################################################################
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
######################################################################################################################
		.data	
######################################################################################################################
		.text
allocate_array:
	lw $t0, 0($sp)						# load array size from stack

	li $v0, 9							# syscall for dynamic memory allocation
	sll $t1,$t0, 2
	move $a0, $t1						# number of bytes to be allocated for array
	syscall

	sw $v0, 4($sp)						# move base address onto stack	

	jr $ra								# return to calling location
######################################################################################################################
######################################################################################################################
#		Subprogram Description
#		read_array reads integer values from the user and stores them
#		in the dynamically allocated array
######################################################################################################################
#		Arguments In and Out of subprogram
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp		base address
#	$sp+4	array size
#	$sp+8
#	$sp+12
######################################################################################################################
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
######################################################################################################################
		.data
read_array_prompt:	.asciiz	"Enter an integer: "
######################################################################################################################
		.text
read_array:
	lw $t0, 0($sp)						# load base address into register $t0
	lw $t1, 4($sp)						# load array size into register $t1

	li $t2, 0							# initialize counter

read_array_loop:
	li $v0, 4
	la $a0, read_array_prompt
	syscall

	li $v0, 5
	syscall

	sw $v0, 0($t0)						# store value in array
	addi $t0, 4							# increment array pointer
	addi $t2, 1							# increment counter

	beq $t2, $t1, read_array_input_done
	b read_array_loop

read_array_input_done:	
	jr $ra								# return to calling location
######################################################################################################################
######################################################################################################################
#		Subprogram Description
#		print_array prints all values from the array
######################################################################################################################
#		Arguments In and Out of subprogram
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp		array base address
#	$sp+4	array size
#	$sp+8
#	$sp+12
######################################################################################################################
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
######################################################################################################################
		.data
######################################################################################################################
		.text
print_array:
	lw $t0, 0($sp)						# load base address into register $t0
	lw $t1, 4($sp)						# load array size into register $t1

	li $t2, 0							# initialize counter

print_array_loop:
	lw $t3, 0($t0)						# load value from array	
			
	li $v0, 1							# print integer
	move $a0, $t3
	syscall

	li $v0, 11							# print character
	li $a0, ' '
	syscall
	
	addi $t0, 4							# increment array pointer
	addi $t2, 1	

	beq $t2, $t1, print_array_input_done
	b print_array_loop

print_array_input_done:	
	jr $ra								# return to calling location
######################################################################################################################
######################################################################################################################
#		Subprogram Description
#		print_every_nth prints every nth value from the array
######################################################################################################################
#		Arguments In and Out of subprogram
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp		array base address
#	$sp+4	array size
#	$sp+8	stride N
#	$sp+12
######################################################################################################################
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
######################################################################################################################
		.data
		print_every_nth_invalid_prompt:	.asciiz "Error: Stride was not greater than 0.\n"
######################################################################################################################
		.text
print_every_nth_invalid:
	li $v0, 4
	la $a0, print_every_nth_invalid_prompt
	syscall
	b print_every_nth_input_done

print_every_nth:
	lw $t0, 0($sp)						# load base address into register $t0
	lw $t1, 4($sp)						# load array size into register $t1
	lw $t4, 8($sp)						# load stride into register $t4

	blez $t4, print_every_nth_invalid	# check for stride lte 0

	li $t2, 0							# initialize counter
	move $t5, $t4						# initialize stride counter, a value will be printed when the stride counter equals the stride
										# then the stride counter will be reset to 1

print_every_nth_loop:	
	bne $t4, $t5, print_every_nth_dont_print	# if stride counter != to stride, don't print anything

	lw $t3, 0($t0)						# load value from array	
	
	li $v0, 1							# print value
	move $a0, $t3
	syscall

	li $v0, 11							# print character
	li $a0, ' '
	syscall
	
	li $t5, 1							# reset stride counter	
	b continue

print_every_nth_dont_print:
	addi $t5, 1							# increment stride counter

continue:
	addi $t0, 4							# increment array pointer
	addi $t2, 1							# increment counter
	beq $t2, $t1, print_every_nth_input_done
	b print_every_nth_loop

print_every_nth_input_done:
	jr $ra								# return to calling location
######################################################################################################################
######################################################################################################################
#		Subprogram Description
#		sum_even_values calculates the sum of all even values in the array
#		and returns the sum
######################################################################################################################
#		Arguments In and Out of subprogram
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp		array base address
#	$sp+4	array size
#	$sp+8	sum of even values
#	$sp+12
######################################################################################################################
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
######################################################################################################################
		.data
######################################################################################################################
		.text
sum_even_values:
	lw $t0, 0($sp)						# load base address into register $t0
	lw $t1, 4($sp)						# load array size into register $t1
	li $t2, 0							# initialize counter
	li $t4, 0							# initialize sum

sum_even_values_loop:	
	lw $t3, 0($t0)						# load value from array

	and $t5, $t3, 1						# result will be 0 if value is even, branch if it isn't
	bne $0, $t5, sum_even_values_odd
	
	add $t4, $t4, $t3					# add to running sum if value is even
	
sum_even_values_odd:
	addi $t0, 4							# increment array pointer
	addi $t2, 1							# increment counter
	beq $t2, $t1, sum_even_values_done
	b sum_even_values_loop

sum_even_values_done:
	sw $t4, 8($sp)
	jr $ra								# return to calling location
######################################################################################################################
######################################################################################################################
#		Subprogram Description
#		reverse_array reverses the array and returns the base address 
#		of the reversed array
######################################################################################################################
#		Arguments In and Out of subprogram
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp		array base address
#	$sp+4	array size
#	$sp+8	reversed base address
#	$sp+12
######################################################################################################################
#		Register Usage
#	$t0	original array base address
#	$t1	array size
#	$t2	array size in bytes
#	$t3	new array base address
#	$t4	
#	$t5	
#	$t6	value out of original array
#	$t7	address pointer, starting at last element of original array
#	$t8
#	$t9
######################################################################################################################
		.data
######################################################################################################################
		.text
reverse_array:	
	lw $t1, 4($sp)						# load array size from stack
	
	addiu $sp, $sp, -12					# allocate space on the stack before calling subprogram
	sw $t1, 0($sp)						# store array size on stack
	sw $ra, 8($sp)						# store return address on the stack

	jal allocate_array

	lw $t3, 4($sp)						# load new array base address	
	lw $ra, 8($sp)						# restore return address

	addiu $sp, $sp, 12					# restore stack pointer

	lw $t0, 0($sp)						# load base address
	lw $t1, 4($sp)						# load array size

	sw $t3, 8($sp)						# store new array base address on stack for caller

	sll $t7, $t1, 2						# bytes in array
	addi $t7, $t7, -4					# bytes from first to last element
	add $t7, $t7, $t0					# address of last element in original array

reverse_array_loop:
	blez $t1, reverse_array_done	
	
	lw $t6, 0($t7)						# get value from original array, starting at end
	sw $t6, 0($t3)						# put value in new array, starting at beginning

	addi $t7, $t7, -4					# decrement original array pointer
	addi $t3, $t3, 4					# increment reversed array pointer

	addi $t1, $t1, -1					# decrement size variable used as counter
	b reverse_array_loop

reverse_array_done:
	jr $ra								# return to calling location
######################################################################################################################