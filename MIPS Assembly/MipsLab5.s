#######################################################################
#			Lab 5 Description
#
#	The purpose of this lab is to help you understand how to
#	access a specific element in an array through its index
#	and how to iterate or search in an array.
#
#	-	In this program, a static array with 10 elements is 
#		already declared in static memory (elements are chosen 
#		randomly between 0 to 20)
#
#	-	In first part of your program, main should use a loop 
#		repeatedly ask user to input a number, call subprogram 
#		array_contains to see whether the array contains this 
#		number, and print out the index of the number after 
#		return. loop should end if user input -1. array_contains
#		will take 3 arguments IN (array base address, array 
#		length, and user input number) and 1 argument OUT (index
#		of the number if array contains the number, -1 if not).
#		
#		(optional) print a message instead of -1 to remaind user
#		that array does not contain the number.
#
#	-	In second part of your program, main should use another
#		loop ask user to input an index (0 <= index < 10), and
#		call print_nth to locate and print the element at that
#		index. Again, loop should end if user input -1. You 
#		should print an error message if user input an invalid
#		index. print_nth will take 2 arguments IN (array base
#		address, and user input index) and no argument out.
#
#		(Hint) check exit code before validate user input since
#		-1 is also an invalid input.
#
#	-	Please notice that all register usage are recomandations
#		not requirements, feel free to follow your own design.
#	
#######################################################################
#			Register Usage
#
#	$t0 base address
#	$t1	index of element found
#	$t2
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8	holds 10
#	$t9	holds -1
#######################################################################
		.data
input_prompt:		.asciiz	"Enter an integer between 0 and 20 inclusive: "
output_prompt:		.asciiz "Number found at index "
not_found_prompt:	.asciiz	"Number does not exist in array.\n"
exit_prompt:		.asciiz "Exiting program.\n"

input_prompt2:      .asciiz "Enter the index value you want to return: "
invalid_input_prompt: .asciiz "Index must be within the bounds of the array.\n"

static_array:		.word	0, 4, 5, 7, 8, 11, 12, 13, 16, 19
#######################################################################
		.text
main:
	li $t8, 10
	li $t9, -1	

main_loop:

	li $v0, 4						# prompt user for a number
	la $a0, input_prompt
	syscall

	li $v0, 5						# read integer
	syscall

	beq	$v0, $t9, next_loop			# branch to next part if -1 was entered	

	move $a2, $v0					# $a2 contains user input
	la $a0, static_array			# $a0 contains base address of static array
	move $a1, $t8					# $a1 contains number of elements in array

	jal array_contains				# call array_contains subprogram

	move $t1, $v0					# store index in $t0

	beq		$t9, $t1, main_not_found # branch if number is not in array
	b main_found

main_not_found:
	li $v0, 4
	la $a0, not_found_prompt
	syscall

	b main_loop

main_found:
	li $v0, 4
	la $a0, output_prompt
	syscall

	li $v0, 1						# output index number
	move $a0, $t1
	syscall
  
    li $v0, 11                      # line break
	li $a0, '\n'
	syscall

	b main_loop

invalid_input: 
    li $v0, 4
    la $a0, invalid_input_prompt
    syscall

next_loop:
    li $v0, 4						# prompt user for a number
	la $a0, input_prompt2
	syscall

	li $v0, 5						# read integer
	syscall

    beq	$v0, $t9, exit			    # branch to exit if -1 was entered
    blt	$v0, $0, invalid_input
    bge	$v0, $t8, invalid_input    

    move $a1, $v0					# $a2 contains user input
	la $a0, static_array			# $a0 contains base address of static array

    jal print_nth

    b next_loop

exit:
	li $v0, 4
	la $a0, exit_prompt
	syscall

	li $v0, 10						# end Program
	syscall
#######################################################################
#######################################################################
#			search_array
#
#	This subprogram will take 3 arguments IN and 1 argument OUT:
#		-	array base address	(argument IN)
#		-	array length			(argument IN)
#		-	search number			(argument IN)
#		-	index of the number	(argument OUT)
#
#	It will iterate through the array to see whether the array 
#	contains the passed in number.
#		-	If yes, this subprogram will return the index of that
#			number
#		-	If no, this subprogram will return -1.	
#
#######################################################################
#			Arguments IN and OUT
#
#	$a0	array base address
#	$a1	array length
#	$a2	user input number
#	$a3
#	$v0	index of the number, -1 if not exist
#	$v1
#######################################################################
#			Register Usage
#
#	$t0	base address of the static array
#	$t1	static array length (10)
#	$t2 user input number
#	$t3 counter
#	$t4	current element
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9 counter
#######################################################################
		.data

#######################################################################
		.text
array_contains:

	move $t0, $a0					# move base address
	move $t1, $a1					# move array length
	move $t2, $a2					# move user input

	li $t3, 0						# initialize counter

array_contains_loop:
	lw		$t4, 0($t0)				# load current element into $t4
	beq $t4, $t2, array_contains_found	# branch if element was found
	addi $t0, $t0, 4				# move pointer in array
	addi $t3, $t3, 1				# increment counter
	bge $t3, $t1, array_contains_not_found
	b array_contains_loop

array_contains_not_found:
	li $v0, -1						# if not found, return -1 
	b array_contains_return

array_contains_found:
	move $v0, $t3					# move counter, which is the index within the array, to return register $v0	
	
array_contains_return:
	jr $ra							# return to main
#######################################################################
#######################################################################
#			print_nth
#
#	This subprogram will take 2 arguments IN and no argument OUT:
#		-	array base address
#		-	user input index
#
#	it will calculate the address of the element at that index
#	using equation:  address = base address + index * size
#	then load the element from memory and print to console.
#######################################################################
#			Arguments IN and OUT
#
#	$a0	array base address
#	$a1	user input index
#	$a2
#	$a3
#	$v0
#	$v1
#######################################################################
#			Register Usage
#
#	$t0	array base address
#	$t1	user input index
#	$t2	temp register to calculate address
#	$t3	element at the index
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
#######################################################################
		.data
print_nth_output: .asciiz "The value in the array is: "
#######################################################################
		.text
print_nth:
	move $t0, $a0                   # move base address
    move $t1, $a1                   # move user input
    sll $t2, $t1, 2                 # multiply index by 4 bytes

    add $t0, $t0, $t2               # address of given index

    lw	$t3, 0($t0)		            # load element at given index

    li $v0, 4
    la $a0, print_nth_output
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
      
    li $v0, 11                      # line break
	li $a0, '\n'
	syscall

	jr $ra							# return to main
#######################################################################