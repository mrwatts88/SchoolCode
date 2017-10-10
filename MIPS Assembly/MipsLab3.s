###########################################################
#       Lab 3
#   Name: Matthew Watts
#   Date:   9/26/2017
#
#   TO DO:
#       Write a program to read temperature values greater than -40 and less than or equal to 140.
#	Notes:
#		1. Valid temperature range is (-40, 140]
#		2. Your program should reject invalid value and print an error message
#		3. Stop reading values when -1 is entered and then
#		4. Save the sum value into static integer variable: sum_p
#		5. Save the count value into static integer variable: count_p
#		6. Print sum_p and count_p values to the console
#
#   Sample run:
#       Enter a value greater than -40 and less than or equal to 140 (-1 to stop): -40
#       Invalid entry
#       Enter a value greater than -40 and less than or equal to 140 (-1 to stop): 140
#       Enter a value greater than -40 and less than or equal to 140 (-1 to stop): 5
#       Enter a value greater than -40 and less than or equal to 140 (-1 to stop): -1
#       Sum: 145
#       Count: 2
#
###########################################################
#       Register Usage
#   $t0     Holds the sum
#   $t1     Holds the count
#   $t2     Holds value -1
#   $t3     Holds value -40
#   $t4     Holds value 140
#   $t5     Holds addresses
#   $t6     Holds input value
###########################################################
        .data
prompt_p:   .asciiz "Enter a value greater than -40 and less than or equal to 140 (-1 to stop): "
sum_p:      .asciiz "Sum: "
count_p:    .asciiz "Count: "
invalid_p:  .asciiz "Invalid entry\n"

nextline_p: .asciiz "\n"                # \n

sum_var_p:      .word 0                 # initialize static variable sum_p to zero
count_var_p:    .word 0                 # initialize static variable count_p to zero
###########################################################
        .text
main:
        li $t0, 0                       # initialize registers
        li $t1, 0
        li $t2, -1
        li $t3, -40
        li $t4, 140

loop_start:
        li $v0, 4                       # string output
        la $a0, prompt_p
        syscall

        li $v0, 5                       # integer input
        syscall

        move $t6, $v0

        beq $t2, $t6, input_done	    # input was -1        
        ble $t6, $t3, invalid	        # input was <= -40
        bgt $t6, $t4, invalid	        # input was > 140

        addi $t1, $t1, 1		        # increment counter
        add $t0, $t0, $t6               # add to sum
        b loop_start

input_done:
        la $t5, sum_var_p               # store values in static memory
        sw $t0, 0($t5)	

        la $t5, count_var_p
        sw $t1, 0($t5)

        li $v0, 4                       # string output
        la $a0, sum_p
        syscall

        li $v0, 1                       # integer output
        move $a0, $t0
        syscall

        li $v0, 4                       # string output
        la $a0, nextline_p
        syscall

        li $v0, 4                       # string output
        la $a0, count_p
        syscall

        li $v0, 1                       # integer output
        move $a0, $t1
        syscall

        b main_end    

invalid:
        li $v0, 4                       # invalid input message
        la $a0, invalid_p
        syscall
        b loop_start        
    
main_end:
        li $v0, 10
        syscall                         # Exit program
###########################################################