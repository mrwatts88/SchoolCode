###########################################################
#       Lab 1
#   Name: Matthew Watts
#   Date: 9/12/17
#
#   TODO:
#       1) Type the distributed handout using notepad
#       2) Save the file as #FirstName#LastName.s
#       3) Run the program in QtSpim (file -> reinitialize and load file)
#       4) Once these steps have been completed, please see your TA to receive credit for this lab
#
#   Description:
#       1) This program prints a Welcome Message on to the screen.
#       2) It then takes input of 2 numbers and adds them
#          together and then prints the result on to the screen.
#
###########################################################
#       Register Usage
#   $t0 First number
#   $t1 Second number
###########################################################
        .data
welcome_p:  .asciiz " Hello Matt! Welcome to CS-315 Lab.\n" 
num1_p:     .asciiz "\n Enter the first integer to be added: "
num2_p:     .asciiz "\n Enter the second integer to be added: "
total_p:    .asciiz "\n The total is: "
###########################################################
        .text
main:
        li $v0, 4               # string output
        la $a0, welcome_p
        syscall
 
        li $v0, 4               #string output
        la $a0, num1_p
        syscall
      
        li $v0, 5               # word input
        syscall
        move 	$t0, $v0	# $t0 = $v0

        li $v0, 4               # string output
        la $a0, num2_p
        syscall

        li $v0, 5               # word input
        syscall
        move 	$t1, $v0	# $t1 = $v0
       
        li $v0, 4               # string output
        la $a0, total_p
        syscall

        add $t3, $t0, $t1       # $t3 = $t1 + $t2

        li $v0, 1               # word output
        move $a0, $t3
        syscall        
    
mainEnd:
        li $v0, 10
        syscall                 # exit
###########################################################