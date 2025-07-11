.data
menu_prompt: .asciiz "Choose an operation:\n"
menu:        .asciiz "1 - Brightness Adjustment\n2 - Grayscale Conversion\n3 - Exit\nChoice: "
enter_rows:  .asciiz "\nEnter number of rows: "
enter_cols:  .asciiz "\nEnter number of columns: "
enter_red:   .asciiz "Enter Red value (0-255): "
enter_green: .asciiz "Enter Green value (0-255): "
enter_blue:  .asciiz "Enter Blue value (0-255): "
brightness_prompt: .asciiz "Enter brightness adjustment value: "
result_msg:  .asciiz "\nYour resultant image matrix is:\n"
newline:     .asciiz "\n"
space:       .asciiz "  "
invalid_op:  .asciiz "Invalid choice.\n"

.text
.globl main
main:
    # Get matrix dimensions
    li $v0, 4
    la $a0, enter_rows
    syscall

    li $v0, 5
    syscall
    move $s0, $v0   # Store row count in $s0

    li $v0, 4
    la $a0, enter_cols
    syscall

    li $v0, 5
    syscall
    move $s1, $v0   # Store column count in $s1

    # Allocate space for matrix (base address in $s2)
    li $s2, 0x10010000  # Start of memory space for matrix

choose_operation:
    # Display menu
    li $v0, 4
    la $a0, menu_prompt
    syscall

    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t9, $v0  # Store choice

    # Execute chosen operation
    beq $t9, 1, brightness_input
    beq $t9, 2, grayscale_input
    beq $t9, 3, exit  # Exit if choice is 3

    # Invalid choice
    li $v0, 4
    la $a0, invalid_op
    syscall
    j choose_operation

# ===================================
# RGB Input for Both Brightness & Grayscale
# ===================================
grayscale_input:
brightness_input:
    li $t0, 0  # Row index
input_rows:
    li $t1, 0  # Column index
input_cols:
    # Ask for Red input
    li $v0, 4
    la $a0, enter_red
    syscall
    li $v0, 5
    syscall
    andi $t4, $v0, 0xFF  # Mask to ensure 8-bit value

    # Ask for Green input
    li $v0, 4
    la $a0, enter_green
    syscall
    li $v0, 5
    syscall
    andi $t5, $v0, 0xFF  # Mask to ensure 8-bit value

    # Ask for Blue input
    li $v0, 4
    la $a0, enter_blue
    syscall
    li $v0, 5
    syscall
    andi $t6, $v0, 0xFF  # Mask to ensure 8-bit value

    # Compute Grayscale: (R + G + B) / 3
    add $t7, $t4, $t5  # Sum R + G
    add $t7, $t7, $t6  # Sum R + G + B
    div $t7, $t7, 3
    mflo $t7  # Get the quotient from division

    # Compute memory address and store grayscale value
    mul $t2, $t0, $s1  # row * num_columns
    add $t2, $t2, $t1  # row_col_index = row * num_columns + col
    mul $t2, $t2, 4    # Convert to byte offset
    add $t2, $t2, $s2  # Compute final memory address
    sw $t7, 0($t2)  # Store grayscale pixel

    # Move to the next column
    addi $t1, $t1, 1
    blt $t1, $s1, input_cols  # If not last column, continue

    # Move to the next row
    addi $t0, $t0, 1
    blt $t0, $s0, input_rows  # If not last row, continue

    beq $t9, 1, brightness_adjustment  # If Brightness was selected, continue
    j print_result_matrix  # Otherwise, proceed to print output

# ===================================
# Brightness Adjustment
# ===================================
brightness_adjustment:
    # Ask for brightness adjustment value
    li $v0, 4
    la $a0, brightness_prompt
    syscall

    li $v0, 5
    syscall
    move $s3, $v0  # Store brightness adjustment value

    li $t0, 0  # Row index
bright_loop_rows:
    li $t1, 0  # Column index
bright_loop_cols:
    # Compute memory address
    mul $t2, $t0, $s1
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    add $t2, $t2, $s2

    # Load pixel value
    lw $t3, 0($t2)
    add $t3, $t3, $s3   # Add brightness

    # Clamping between 0-255
    li $t5, 255
    bgt $t3, $t5, clamp_max_bright
    blt $t3, $zero, clamp_min_bright
    j store_bright

clamp_max_bright:
    move $t3, $t5
    j store_bright

clamp_min_bright:
    move $t3, $zero

store_bright:
    sw $t3, 0($t2)

    # Move to next column
    addi $t1, $t1, 1
    blt $t1, $s1, bright_loop_cols

    # Move to next row
    addi $t0, $t0, 1
    blt $t0, $s0, bright_loop_rows

    j print_result_matrix

# ===================================
# Print Resultant Image Matrix
# ===================================
print_result_matrix:
    li $v0, 4
    la $a0, result_msg
    syscall

    li $t0, 0  # Row index
print_loop_rows:
    li $t1, 0  # Column index
print_loop_cols:
    mul $t2, $t0, $s1
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    add $t2, $t2, $s2

    lw $t3, 0($t2)  # Load grayscale pixel

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t1, $t1, 1
    blt $t1, $s1, print_loop_cols

    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 1
    blt $t0, $s0, print_loop_rows

    j exit

exit:
    li $v0, 10
    syscall
