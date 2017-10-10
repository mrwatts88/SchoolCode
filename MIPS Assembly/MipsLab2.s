###########################################################
#       Lab 2
#
#   Name: Matthew Watts
#   Date: 9/19/17
#
#   TODO:
#       part 1:
#       - prompt user to input height and width of a right triangle
#       - compute the area of the right triangle (width * height / 2)
#         and print out the result to one decimal place (ie: 42.3)
#
#       part 2:
#       - add basic input validation to make sure both height and
#         width are greater than zero.
#       - print out an error message and ask user to input again if 
#         the input is less than or equal to zero.
#       - upload your .s file to D2L under "Lab #2 Triangle area"
#
#   Note:
#       1. Please fill out the register usage section.
#       2. Please notice that the remainder of any number divide by 2
#          is either 0 or 1 in binary. Therefore, fractional part of 
#          the result is either ".0" or ".5" in decimal respectively.
#
###########################################################
#       Register Usage
#
#   $t0 triangle width
#   $t1 triangle height
#   $t2 $t0*$t1
#   $t3 = 2
#   $t4 = lo
#   $t5 = hi
#   $t6
#   $t7
#   $t8
#   $t9
###########################################################
        .data
triangle_width:  .asciiz "Input the width of the triangle: \n" 
triangle_height:  .asciiz "Input the height of the triangle: \n"
invalid_width:  .asciiz "Width must be greater than 0.\n"
invalid_height:  .asciiz "Height must be greater than 0.\n"
point_zero:  .asciiz ".0" 
point_five:  .asciiz ".5" 
triangle_area:  .asciiz "The area of the triangle is: " 
###########################################################
        .text
invalid_width_branch:
        li $v0, 4                       
        la $a0, invalid_width
        syscall
main:
        li $v0, 4                       # string output
        la $a0, triangle_width
        syscall

        li $v0, 5                       # word input (width)
        syscall
        move 	$t0, $v0
        blez 	$t0, invalid_width_branch
        b correct_height_branch   
           
invalid_height_branch:
        li $v0, 4                       
        la $a0, invalid_height
        syscall

correct_height_branch:
        li $v0, 4                       # string output
        la $a0, triangle_height
        syscall

        li $v0, 5                       # word input (height)
        syscall
        move 	$t1, $v0	    

        blez 	$t1, invalid_height_branch   

        mult	$t0, $t1		        # $t0 * $t0 = Hi and Lo registers
        mflo	$t2				        # copy Lo to $t2

        li		$t3, 2 		            # $t3 = 2 
        
        div		$t2, $t3		        # $t2 / 2
        mflo	$t4				        # $t4 = result
        mfhi	$t5				        # $t5 = remainder        

        li $v0, 4                       # string output
        la $a0, triangle_area
        syscall

        li $v0, 1                       # integer output (result without remainder)
        move $a0, $t4
        syscall

        bgtz $t5, point_five_branch 	# if $t5 > 0

        li $v0, 4                       # string output (".0")
        la $a0, point_zero
        syscall

        b exit        

point_five_branch:
        li $v0, 4                       # string output (".5")
        la $a0, point_five
        syscall
        
exit:
        li $v0, 10                      # exit program
        syscall
###########################################################