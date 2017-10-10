###########################################################
#   Lab 0
#   Name: Matthew Watts
#   Date: 9/5/2017
#
#   Description:
#       This program prints Hello World on to the screen.
###########################################################
    .data
hello_p:    .asciiz "Hello World!!!\n"
###########################################################
    .text
main:
    li $v0, 4        # print Hello World
    la $a0, hello_p
    syscall

    li $v0, 10      # end program
    syscall
###########################################################