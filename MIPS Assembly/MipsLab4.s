###########################################################
#       Lab 4
#   Name:   Matthew Watts
#   Date:   10/3/2017
#
#   Note:
#       Take a screenshot of data section of QtSPIM (which would imply that entered values
#       are correctly stored in memory) and submit it to D2L as well.     
#  
#   Description:
#       Write main and subprogram names: allocate_array, read_values.
#
#       main: it initializes two static variables sum_var_p and count_var_p, also static and dynamic array of 10 integers.
#			  First the main will call a subprogram named allocate_array and pass the number of elements you want to store in the
#			  dynamic array. allocate_array will return the base address of the dyanmic array using one of argument OUT registers. 
#			  Then main will store the base address of the dynamic array in a static variable named array_d.
#			  
#		      Then main will call subprogram read_values and pass base addresses of static array and dynamic array as arguments IN. 
#			  and store the returned(or argument OUT) sum and count into static variables sum_var_p and count_var_p and print sum,
#			  count and average.
#			  
#			  Then main will call print_array sub-program twice to print the content of both arrays one by one by passing the base-address
#			  and array length of each array at a time.#
#
#       allocate_array:
#				IN: maximum number of elements.
#				OUT: base address of dynamic array.
#			This subprogram will read the no. of elements you want to store in dynamic array from the specific argument IN register.
#			Then this sub-program will allocate a dynamic array using the number of elements, element size and syscode '9'. At last,
#			it will return the base address of the dynamic array using one of argument OUT registers to the main.
#		
#		read_values: 
#				IN: maximum number of elements, base_address_of_static_array, base_address_of_dynamic_array
#				OUT: sum and count
#			This program, will read the maximum number of elements, base address of the static array and base address of the dynamic array
#			from the specified argument IN registers. Then it will take the inputs from the user one by one. The validdation of the inputs is same 
#			as program-1. Every input has to be a non-negative even number. If an input is indeed a valid input the subprogram will store the number
#			in the static and dynamic array sequentially. When the count of valid numbers reaches the maximum number of elements or if at any point
#			of time user gives -9 as an input before reaching the maximum count, the sub-program will then stop takinbg input from the user and will
#			return the sum and count of valid numbers to main.	
#
#		print_array:
#				IN: base-address of static/dyanmic array, length of the array, length of the array
#				OUT: None
#			This subprogram will read the base address of an array and its length. Then it will print all values of that array one by one. 
#		
#   High level design:
#       main:
#			dynamic array base-address <-- allocate_array(no. of elements)
#			
#			store dynamic array base-address in static variable array_d.
#			
#           sum & count <-- read_values(max_limit, base address of static array, base address of dynamic array)
#           
#           store sum & count in static variables "sum_var_p", "count_var_p" respectively
#
#           print sum, count and integer average           
#
#       read_values(max_limit, base address of static array, base address of dynamic array):
#           initialize sum and count to 0
#
#           while (true) {
#               prompt for number and read number
#
#               if (number == -9 ) {
#                   break
#               }
#               
#               if (number < 0) {
#                   print error message
#               }
#				if (number is odd) {
#                   print error message
#               }
#                            
#               static_array[base address] = number
#               base address = base address + 4     // because integers are 4 bytes in MIPS
#                                                   // and addresses in MIPS are in bytes
#				dynamic_array[base address] = number
#               base address = base address + 4     // because integers are 4 bytes in MIPS
#                                                   // and addresses in MIPS are in bytes
#
#               sum = sum + number
#               count = count + 1
#				if (count == 10) {
#                   break
#               }				
#           }
#
#           return sum & count in register $v0 and $v1 respectively
#
###########################################################
#       Register Usage
#   $t0     Holds the returned sum
#   $t1     Holds the returned count
#   $t3
#   $t4
#   $t5
#   $t6
#   $t7
#   $t8
#   $t9     Hold array length = 10
###########################################################
        .data
sum_p:          .asciiz "Sum: "
count_p:        .asciiz "Count: "        
average_p:      .asciiz "Average: "
nextline_p:     .asciiz "\n"
d_array:		.asciiz "\n Dynamic Array \n"
s_array:		.asciiz "\n Static Array \n"

array_p:        .word 0:10      # array of 10 integers each initialized to 0
array_d:		.word 0			# address of the dynamic array as a content of static variable  
        
sum_var_p:      .word 0         # sum variable initialized to 0
count_var_p:    .word 0         # count variable initialized to 0
###########################################################
        .text
main:
    li $t9, 10
    move $a0, $t9       # number of elements in dynamic array
    jal allocate_array  # call subprogram

    la $t0, array_d
    sw $v0, 0($t0)   # store base address of dynamic array

    li $t9, 10
    move $a0, $t9   # number of elements in dynamic array
    la $a1, array_p # address of static array
    move $a2, $v0   # address of dynamic array

    jal read_values # call subprogram

    la $t0, sum_var_p
    sw $v0, 0($t0)  # store sum

    la $t0, count_var_p
    sw $v1, 0($t0)  # store count

    li $v0, 4                   # print sum is
    la $a0, sum_p
    syscall

    li $v0, 1                   # print sum integer
	la $t0, sum_var_p				# load the sum from static variable into $t1 and then move it to $a0.
    lw $t0, 0($t0)
    move $a0, $t0
    syscall

    li $v0, 11                  # print newline character
    li $a0, 13
    syscall

    li $v0, 4                   # print count is
    la $a0, count_p
    syscall

    li $v0, 1                   # print count integer
	la $t1, count_var_p				# load the count from static variable into $t1 and then move it to $a0.
    lw $t1, 0($t1)
    move $a0, $t1
    syscall

    li $v0, 11                  # print newline character
    li $a0, 13
    syscall

    li $v0, 4                   # print average is
    la $a0, average_p
    syscall

    beqz $t1, divide_by_zero    # if count is zero, we should not divide sum by zero
    
    li $v0, 1                   # print quotient
    div $a0, $t0, $t1           # divide sum by count and put quotient in register $a0
    syscall

    b mainEnd                   # branch unconditionally to halt

divide_by_zero:
    li $v0, 1                   # print zero
    move $a0, $0
    syscall
                 
mainEnd:
	li $v0, 4                   # print "Static Array" 
    la $a0, s_array
    syscall

    li $t9, 10

    la $a0, array_p #load the base-address of static array in argument IN register
    move $a1, $t9   #load the length of the array in argument IN register
    jal print_array #call print_array subprogram								
								
	li $v0, 4                   # print "Dynamic Array" 
    la $a0, d_array
    syscall

    li $t9, 10
	
    la $a0, array_d #load the base-address of dynamic array in argument IN register
    lw $a0, ($a0)
    move $a1, $t9   #load the length of the array in argument IN register
    jal print_array #call print_array subprogram					

exit:								
    li $v0, 10
    syscall                     # Halt
###########################################################
#      allocate_array subprogram
#
#   Subprogram description:
#       This subprogram will receive one argument(number of elements) in argument IN register and returns one argument OUT at end.
#       Then, it will allocate a dynamic integer array(using system call 9 and length) and return the address of dynamic array using $v0.
#
###########################################################
#       Arguments IN and OUT of subprogram
#   $a0	Length of Array
#   $a1
#   $a2
#   $a3
#   $v0 Holds base address of dynamic array
#   $v1  
#   $sp
#   $sp+4
#   $sp+8
#   $sp+12
###########################################################
#       Register Usage
#   $t0  Holds array length.
#   $t1  Holds array size pointer (address) 
###########################################################
        .data
###########################################################
        .text
allocate_array:
    move $t0, $a0 # move number of elements

    sll $t1, $t0, 2 # number of bytes to be allocated
    
    li $v0, 9   # allocate memory for array
    move $a0, $t1
    syscall # v0 contains address

    b allocate_array_end

allocate_array_end:
     jr		$ra		# jump back to the main
###########################################################
###########################################################
#       read_values subprogram
#
#   Subprogram description:
#       Write an assembly sub-program that will read a series of non-negative integers (greater than or equal to zero)
#       that are even, store them in static and dynamic array one at a time, count them and then add them up. It will 
#		stop reading when -9 is entered OR count of numbers becomes 10, it will print out an error for all invalid inputs
# 		and those invalid entries will be ignored. After all the integers are read, the sub-program will return the sum and count
#		using $v0 and $v1.
#			
###########################################################
#       Arguments IN and OUT of subprogram
#   $a0     Array length
#   $a1		Holds base address of an array
#   $a2		Holds base address of an array
#   $a3
#   $v0     Holds sum
#   $v1     Holds count
#   $sp
#   $sp+4
#   $sp+8
#   $sp+12
###########################################################
#       Register Usage
#   $t0     Holds sum
#   $t1     Holds count
#   $t2     Holds base address of an array (that will get incremented by 4 on each iteration)
#   $t3     Holds base address of an array (that will get incremented by 4 on each iteration)
#   $t4
#   $t5
#   $t6     Holds remainder of dividing number by 2
#   $t7     Holds constant value -9
#   $t8     Holds the Array length
#   $t9     Holds constant value 2
###########################################################
        .data
read_values_prompt_p:   .asciiz "Enter a non-negative integer (greater than or equal to zero) that are even: "
read_values_invalid_p:  .asciiz "Invalid entry. Number should be even and non-negative.\n"
###########################################################
        .text
read_values:
# load argument IN:
	move $t8, $a0   # load the array length and put in register $t8
	move $t2, $a1				# load base address of array and put in register $t2
	move $t3, $a2				# load base address of array and put in register $t3
    
    li $t0, 0                   # initialize sum to zero
    li $t1, 0                   # initialize count to zero
    li $t7, -9                  # initialize $t7 to constant value -9       
    li $t9, 2                   # initialize $t9 to constant value 2      
      
read_values_entry_loop:
    li $v0, 4                   # prompt for number
    la $a0, read_values_prompt_p
    syscall

    li $v0, 5                   # read integer
    syscall

    beq $v0, $t7, read_values_calculation   # branch to calculation if value is -9
    
    bltz  $v0, read_values_invalid_entry    # branch to invalid_entry if value is less than zero
    
    rem $t6, $v0, $t9                       # divide the number by 2 and put entry into register $t6
    bnez $t6, read_values_invalid_entry     # branch to invalid_entry if value is odd
    
    add $t0, $t0, $v0                       # add the number to the sum
    addi $t1, $t1, 1                        # increment count by 1    
	
	sw $v0, 0($t2)							# store the valid number into arrays
    sw $v0, 0($t3)
	addi $t2, $t2, 4						# increment base address of array by 4 because integers
    addi $t3, $t3, 4                                    # are 4 bytes and addresses in MIPS are in bytes
											
	beq $t1, $t8, read_values_calculation   # branch to calculation if count value is 10	

    b read_values_entry_loop                # branch unconditionally to the beginning of the loop

read_values_invalid_entry:
    li $v0, 4                   # print error message
    la $a0, read_values_invalid_p
    syscall

    b read_values_entry_loop    # branch unconditionally to read_values_entry_loop

read_values_calculation:
# return arguments OUT
	move $v0, $t0						   # return sum in register $v0
	move $v1, $t1   					   # return count in register $v1

read_values_end: 
	jr		$ra							   # jump back to the main

###########################################################
###########################################################
#      print_array subprogram
#
#   Subprogram description:
#       This subprogram will receive two argument(base address of an array and the length of the array) in argument IN registers and returns prints 
#		contents of the array. This sub-program does not return anything
###########################################################
#       Arguments IN and OUT of subprogram
#   $a0	Base Address of an Array
#   $a1	Length of Array
#   $a2
#   $a3
#   $v0 
#   $v1  
#   $sp
#   $sp+4
#   $sp+8
#   $sp+12
###########################################################
#       Register Usage
#   $t0  Base Address of an Array
#   $t1  Holds array length. 
###########################################################
        .data
print_array_tab:  .asciiz      "\t"
###########################################################
        .text
print_array:
	move $t0, $a0					# load the base-address of an array from argument IN register to $t0 register
	move $t1, $a1					# load the length of an array from argument IN register to $t1 register

print_array_loop:
	beqz $t1, print_array_end
	
	li $v0, 1					# Print the content stored at 0($t0)
    lw $a0, 0($t0)
    syscall
						
	li $v0, 4
	la $a0, print_array_tab		# print a Tab
	syscall					
						
	addi $t0, $t0, 4	# increment base address of array by 4 because integers
                        # are 4 bytes and addresses in MIPS are in bytes
	addi $t1, $t1, -1					
	b print_array_loop
print_array_end:
     jr		$ra	        # jump back to the main

###########################################################